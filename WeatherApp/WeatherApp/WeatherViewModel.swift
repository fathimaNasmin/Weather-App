//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
	@Published var forecast: WeatherModel
	@Published var cityList: [CityModel] = []
	@Published var searchText: String = ""
	@Published var isLoading: Bool = true
	
	private var cancellables: Set<AnyCancellable> = []
	
	private let fetcher = FetchService()
	
	var filteredCountry: [CityModel] {
		guard !searchText.isEmpty && searchText.count >= 3 else { return [] }
		
		return cityList
	}
	
	init() {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		guard let data = Bundle.main.url(forResource: "sampleForecast", withExtension: "json") else {
			fatalError("\'sampleForecast.json\' file not found in the bundle.")
		}
		
		do {
			let forecastData = try Data(contentsOf: data)
			forecast = try decoder.decode(WeatherModel.self, from: forecastData)
			
		}catch {
			fatalError("Failed to load or decode JSON format : \(error)")
		}
		
		trackChangeInSearchText()
	}
	
	/// Function that tracks the changes in searchText and update the result
	func trackChangeInSearchText() {
		// To observe searchText changes
		$searchText
			.debounce(for: .milliseconds(300), scheduler: DispatchQueue.main) // Prevents frequent API calls
			.removeDuplicates() // avoid unnecessary updates
			.sink { [weak self] searchText in
				guard let self = self, searchText.count >= 3 else { return }
				Task {
					await self.updateCityList()
				}
			}
			.store(in: &cancellables)
	}
	
	/// Function that updates the cityList
	@MainActor
	func updateCityList() async {
		do {
			cityList = try await fetcher.fetchCitySuggestion(from: searchText)
		}catch{
			print("Error fetching: \(error)")
		}
	}
	
	/// Function that fetches the weather data for the city
	@MainActor
	func fetchWeatherForecast(for city: String) async {
		do {
			forecast = try await fetcher.fetchWeather(for: city)
		}catch{
			print("Error on fetching weather for the city \(city): \(error)")
		}
	}
	
	/// Async Function to fetch the weather with coordinates of the user
	@MainActor
	func fetchWeatherForecast(in coordinates: CLLocationCoordinate2D) async {
		isLoading = false
		
		let latitude = coordinates.latitude
		let longitude = coordinates.longitude
		
		do {
			forecast = try await fetcher.fetchWeatherWithLocation(latitude: latitude, longitude: longitude)
		}catch{
			print("Error on fetching weather in the current location: \(error)")
		}
	}
}
