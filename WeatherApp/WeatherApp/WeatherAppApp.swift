//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI
import Combine

@main
struct WeatherAppApp: App {
	@StateObject private var weatherVM = WeatherViewModel()
	@StateObject private var cityCoreDatavm = CityCoreDataViewModel()
	@StateObject private var temperatureUnitState = TemperatureUnitState()
	@StateObject var locationManager = LocationManager()
	
	@State private var cancellables = Set<AnyCancellable>()
	@State var selectedCityTab: String = ""
	
    var body: some Scene {
		WindowGroup {
			TabView(selection: $selectedCityTab) {
				// First Tab: Shows Current location weather
				if !weatherVM.isLoading {
					MainView(cityCoreDataVM: cityCoreDatavm, selectedCityTab: $selectedCityTab, isCurrentLocation: true, weather: weatherVM.forecast)
						.tag("CurrentLocation")
				} else {
					// Placeholder for when current location weather data is not available
					LoadingView()
						.tag("CurrentLocation")
				}
				
				ForEach(cityCoreDatavm.storedCityNames, id: \.self) { cityName in
					if let weather = cityCoreDatavm.storedCityWeatherData[cityName] {
						MainView(cityCoreDataVM: cityCoreDatavm, selectedCityTab: $selectedCityTab, isCurrentLocation: nil, weather: weather)
							.tag(cityName)
					}
				}
			}
			.tabViewStyle(.page)
			.ignoresSafeArea()
			.environmentObject(temperatureUnitState)
			.environmentObject(weatherVM)
			.onAppear {
				locationManager.checkLocationAuthorization()

				// Observe updates to lastKnownLocation
				locationManager.$lastKnownLocation
					.compactMap { $0 } // Ensure non-nil coordinates
					.first() // Execute only for the first valid location
					.sink { locationCoordinates in
						Task {
							await weatherVM.fetchWeatherForecast(in: locationCoordinates)
						}
					}
					.store(in: &cancellables) // Retain the subscription
				
				Task {
					await cityCoreDatavm.fetchStoredCityWeatherData()
				}
			}
		}
    }
}


