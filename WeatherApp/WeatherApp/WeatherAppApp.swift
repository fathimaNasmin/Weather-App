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
	@StateObject private var vm = WeatherViewModel()
	@StateObject private var cityCoreDatavm = CityCoreDataViewModel()
	@StateObject private var temperatureUnitState = TemperatureUnitState()
	
	@StateObject var locationManager = LocationManager()
	
	@State private var cancellables = Set<AnyCancellable>()
	
    var body: some Scene {
		WindowGroup {
			TabView {
				// First Tab: Current location weather
				if !vm.isLoading {
					ContentView(vm: vm, cityCoreDataVM: cityCoreDatavm, weather: vm.forecast)
						.tag("CurrentLocation")
				} else {
					// Placeholder for when current location weather data is not available
					LoadingView()
						.tag("CurrentLocation")
				}
//				ContentView(vm: vm, cityCoreDataVM: cityCoreDatavm, weather: vm.forecast)
				
				ForEach(cityCoreDatavm.storedCityNames, id: \.self) { cityName in
					if let weather = cityCoreDatavm.storedCityWeatherData[cityName] {
						ContentView(vm: vm, cityCoreDataVM: cityCoreDatavm, weather: weather)
					}
				}
			}
			.tabViewStyle(.page)
			.ignoresSafeArea()
			.environmentObject(temperatureUnitState)
			.onAppear {
				locationManager.checkLocationAuthoriazation()

				// Observe updates to lastKnownLocation
				locationManager.$lastKnownLocation
					.compactMap { $0 } // Ensure non-nil coordinates
					.first() // Execute only for the first valid location
					.sink { locationCoordinates in
						Task {
							await vm.fetchWeatherForecast(in: locationCoordinates)
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


// TODO:

// ContentView: convert to C or F
// SearchView: Remove search list and add default feature that same as in weather app
// SearchView: Remove clearing text after button tapped


// MainContentView: Show hourly weather from Now()
// MainContentView: Show chance of rain from Now()

