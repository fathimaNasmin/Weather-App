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
	@StateObject var locationManager = LocationManager()
	@StateObject private var vm = WeatherViewModel()
	@State private var cancellables = Set<AnyCancellable>()
	
    var body: some Scene {
        WindowGroup {
			ContentView(vm: vm)
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
				}
        }
    }
}


// TODO:

// ContentView: convert to C or F
// SearchView: Remove search list and add default feature that same as in weather app
// SearchView: Remove clearing text after button tapped

// @Action: Add to the city name to the core data or swift data
// Core location: On app open, get the weather of the current location of the device.
// core data or swift data: To store the several city names


// MainContentView: Show hourly weather from Now()
// MainContentView: Show chance of rain from Now()
