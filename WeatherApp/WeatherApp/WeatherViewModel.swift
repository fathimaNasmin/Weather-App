//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
	@Published var forecast: WeatherModel
	@Published var searchText: String = ""
	@Published var cityList: [CityModel] = []
	
	private var cancellables: Set<AnyCancellable> = []
	
	private let fetcher = FetchService()
	
	var filteredCountry: [CityModel] {
		guard !searchText.isEmpty && searchText.count >= 3 else { return [] }
		
		return cityList
	}
	
	// Fetch the data based on searchText
	@MainActor
	func updateCityList() async {
		do {
			cityList = try await fetcher.fetchCitySuggestion(from: searchText)
		}catch{
			print("Error fetching: \(error)")
		}
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
	
	
}
