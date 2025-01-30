//
//  Utilities.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import Foundation
import SwiftUI


extension Double {
	/// Function to round the double value to the specified decimal place and returns string format
	/// - Parameters:
	/// 	- decimalPlace: How many decimal value to round
	/// - Returns:
	/// 	- Returns in string format
	func rounded(to decimalPlace: Int) -> String {
		String(format: "%.\(decimalPlace)f", self)
	}
}


extension Color {
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		let scanner = Scanner(string: hex)
		
		if hex.hasPrefix("#") {
			scanner.currentIndex = hex.index(after: hex.startIndex)
		}
		
		var rgbValue: UInt64 = 0
		scanner.scanHexInt64(&rgbValue)
		
		let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
		let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
		let blue = Double(rgbValue & 0x0000FF) / 255.0
		
		self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
	}
}


// For Preview
/// A Sample WeatherModel data for showing in Preview
extension WeatherModel {
	static var sample: WeatherModel {
		WeatherModel(
			location: Location(
				name: "New York",
				currentDateEpoch: Date(),
				timeZoneId: "America/New_York"
			),
			current: Current(
				tempC: 15.0,
				tempF: 59.0,
				condition: Current.Condition(text: "Sunny"),
				windKph: 10.0,
				pressureIn: 30.12,
				rainInMm: 0.0,
				humidity: 50,
				feelslikeC: 15.0,
				feelslikeF: 59.0,
				dewpointC: 10.0,
				visibility: 16.0
			),
			forecast: Forecast(
				forecastDay: [
					Forecast.SevenForecastDay(
						date: "2025-01-14",
						dateEpoch: Date(),
						day: Forecast.SevenForecastDay.SingleDay(
							maxTempC: 18.0,
							maxTempF: 64.4,
							minTempC: 10.0,
							minTempF: 50.0,
							condition: Forecast.SevenForecastDay.SingleDay.TodayCondition(text: "Partly Cloudy"),
							dailyChanceOfRain: 20
						),
						hourly: [
							HourForecast(
								timeEpoch: 1618286400,
								time: "2025-01-14 12:00",
								tempC: 15.0,
								tempF: 59.0,
								chanceOfRain: 10
							)
						]
					)
				]
			)
		)
	}
}
