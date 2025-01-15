//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
	@Published var forecast: WeatherModel
	
	init() {
		let decoder = JSONDecoder()
//		decoder.keyDecodingStrategy = .convertFromSnakeCase
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
	}
}
