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
	
	private let apiService = FetchService()
	
	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	
	init() {
		container = NSPersistentContainer(name: "Weather")
		context = container.viewContext
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
	
	
	/// Function to fetch the all city names from the persistent store and store it in an array
	func fetchStoredCities() {
		let request: NSFetchRequest<City> = City.fetchRequest()
		
		do {
			let fetchedCities = try container.viewContext.fetch(request).map { $0.name! }
			DispatchQueue.main.async {
				self.storedCityNames = fetchedCities
			}
		} catch {
			print("Error on fetching data")
		}
	}
	
	
	/// Function to add the city name to the persistent store
	func addCityName(cityName: String) async {
		if cityName.isEmpty { return }
		
		// Check if the city name already exists
		if !cityNameExists(cityName: cityName) {
			if !storedCityNames.contains(cityName) {
				let newCity = City(context: context)
				newCity.id = UUID()
				newCity.name = cityName
				DispatchQueue.main.async {
					self.storedCityNames.append(cityName)
				}
				await saveData()
				
				print("Added to the store")
			}
		} else {
			return
		}
	}
	
	/// Function to check whether the name already exists in persistance store
	func cityNameExists(cityName: String) -> Bool {
		let request: NSFetchRequest<City> = City.fetchRequest()
		request.predicate = NSPredicate(format:"name == %@", cityName)

		do {
			let count = try context.count(for: request)
			return count > 0
		}catch {
			print("Error checking name existence: \(error)")
			return false
		}
	}
	
	/// Function to delete the city from the persistant store
	func deleteCity(indexSet: IndexSet) async {
		guard indexSet.first != nil else {return}
		
		for index in indexSet {
			let cityData = storedCityNames[index]
			
			let request: NSFetchRequest<City> = City.fetchRequest()
			request.predicate = NSPredicate(format:"name == %@", cityData)
			
			do {
				let result = try context.fetch(request)
				if let objectToDelete = result.first {
					// Delete the object from Core Data
					context.delete(objectToDelete)
					
					await saveData()
				}
			} catch {
				print("Error deleting object: \(error)")
			}

		}
	}
	
	/// Function to get the latest data from the persistance store
	func getLatestData() async {
		do {
			try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
			fetchStoredCities() // To get the updated data from core data
			await fetchStoredCityWeatherData()
		}catch{
			print("Error while retrieving data")
		}
	}
	
	/// Function to save the data to the core data
	func saveData() async{
		do {
			try container.viewContext.save()
			await getLatestData()
		}catch let error {
			print("Error on saving: \(error)")
		}
	}
}
