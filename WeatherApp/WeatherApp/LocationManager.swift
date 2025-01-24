//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/22/25.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
	@Published var lastKnownLocation: CLLocationCoordinate2D?
	var manager = CLLocationManager() // will allow to get access to location services
	
	override init() {
		super.init()
		manager.delegate = self
	}
	
	func checkLocationAuthoriazation() {
		manager.startUpdatingLocation()
		
		switch manager.authorizationStatus {
		case .notDetermined:
			manager.requestWhenInUseAuthorization()
			
		case .restricted, .denied:
			print("Location access denied or restricted")
			
		case .authorizedAlways, .authorizedWhenInUse:
			manager.startUpdatingLocation()
			
		@unknown default:
			print("Unhandled location authorization status")
		}
	}
	
	/// Trigged every time authorization status changes
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthoriazation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			DispatchQueue.main.async {
				self.lastKnownLocation = location.coordinate
			}
		}
	}
}
