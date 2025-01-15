//
//  Utilities.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import Foundation


extension Double {
	func rounded(to decimalPlace: Int) -> String {
		String(format: "%.\(decimalPlace)f", self)
	}
}
