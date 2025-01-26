//
//  CityCoreDataViewModel.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/24/25.
//

import Foundation
import CoreData
import Combine

class CityCoreDataViewModel: ObservableObject {
	@Published var storedCityNames: [String] = []
	@Published var storedCityWeatherData: [String: WeatherModel] = [:]
	
	let container: NSPersistentContainer
	
	private let apiService = FetchService()
	
	init() {
		container = NSPersistentContainer(name: "Weather")
		// to load all data from the container
		container.loadPersistentStores { (description, error) in
			if let error = error {
				print("Error loading core data: \(error)")
			}
		}
		fetchStoredCities()
	}
	
	
	/// Function to fetch the weather data for all the cities
	func fetchStoredCityWeatherData() async {
		guard !storedCityNames.isEmpty else {
			print("DB empty")
			return
		}
		
		await withTaskGroup(of: (String, WeatherModel)?.self) { group in
			for city in storedCityNames {
				group.addTask {
						do {
							let weather = try await self.apiService.fetchWeather(for: city)
							return (city, weather)
						} catch {
							print("Error fetching weather for \(city): \(error)")
							return nil
						}
					}
			}
			
			for await result in group {
				if let (cityName, weather) = result {
					DispatchQueue.main.async {
						self.storedCityWeatherData[cityName] = weather
					}
				}
			}
		}
}
	
	
	/// Function to fetch the data from the core data
	func fetchStoredCities() {
		let request: NSFetchRequest<City> = City.fetchRequest()
		
		do {
			let fetchedCities = try container.viewContext.fetch(request).map { $0.name! }
			DispatchQueue.main.async {
				self.storedCityNames = fetchedCities
			}
			print("Stored City Names: \(storedCityNames)")
		} catch {
			print("Error on fetching data")
		}
	}
	
	
	/// Functin to add the city name to the core data
	func addCityName(cityName: String) async {
		if cityName.isEmpty { return }
		
		// Check if the city name already exists
		let request: NSFetchRequest<City> = City.fetchRequest()
		request.predicate = NSPredicate(format:"name == %@", cityName)
		

		if !storedCityNames.contains(cityName) {
			let newCity = City(context: container.viewContext)
			newCity.id = UUID()
			newCity.name = cityName
			storedCityNames.append(cityName)
			await saveData()

			print("Added to the store")
		}
	}
	
	/// Function to delete the city from the core data
	// Refer to id instead of indexSet
//	func deleteCityName(indexSet: IndexSet) {
//		guard let index = indexSet.first else {return}
//		let entity = storedCityNames[index]
//		storedCityNames.remove(at: index)
//		container.viewContext.delete(entity)
//		saveData()
//		print("Deleted from store")
//	}
	
	/// Function to save the data to the core data
	func saveData() async{
		do {
			try container.viewContext.save()
			fetchStoredCities() // To get the updated data from core data
			await fetchStoredCityWeatherData()
		}catch let error {
			print("Error on saving: \(error)")
		}
	}
}
