//
//  FetchService.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/19/25.
//

import Foundation

struct FetchService {
	private enum FetchError: Error {
		case badResponse
	}
	
	
	// Fetching the city suggestions for search
	func fetchCitySuggestion(from query: String) async throws -> [CityModel]{
		// Creation of URL
		let baseUrl = URL(string: APIConstants.searchAPIUrl)
		
		var urlComponents = URLComponents(url: baseUrl!, resolvingAgainstBaseURL: false)
		
		urlComponents?.queryItems = [
			URLQueryItem(name: "key", value: apiKey),
			URLQueryItem(name: "q", value: query)
		]
		
		let searchUrl = urlComponents?.url
		
		// Fetch the data
		let (data, response) = try await URLSession.shared.data(from: searchUrl!)
		
		// Handle the response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw FetchError.badResponse
		}
		
		// Decode the response
		let cityCollection = try JSONDecoder().decode([CityModel].self, from: data)
		
		return cityCollection
	}
	
	
	// Fetch request for the city
	func fetchWeather(for city: String) async throws -> WeatherModel {
		// Create the url
		let baseUrl = URL(string: APIConstants.forecastAPIUrl)
		
		var urlComponents = URLComponents(url: baseUrl!, resolvingAgainstBaseURL: false)
		
		urlComponents?.queryItems = [
			URLQueryItem(name: "key", value: apiKey),
			URLQueryItem(name: "q", value: city),
			URLQueryItem(name: "days", value: "9")
		]
		
		let searchUrl = urlComponents?.url
		
		// Fetch the data from response
		let (data, response) = try await URLSession.shared.data(from: searchUrl!)
		
		// Handle the response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			print(response)
			throw FetchError.badResponse
		}
		
		// Decode the response
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		let forecastForCity = try decoder.decode(WeatherModel.self, from: data)
		return forecastForCity
	}
}
