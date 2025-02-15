//
//  CityItemView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/28/25.
//

import SwiftUI

struct CityItemView: View {
	@EnvironmentObject var temperatureUnit: TemperatureUnitState
	let weatherData: WeatherModel
	
    var body: some View {
		ZStack {
			if let weatherCondition = WeatherCondition(rawValue: weatherData.current.condition.text) {
				weatherCondition.backgroundGradient
			} else {
				Color.gray.opacity(0.4)
			}
			
			VStack {
				HStack {
					Text(weatherData.location.name)
						.fontWeight(.bold)
					Spacer()
					
					Text("\(temperatureUnit.isCelsius ? weatherData.current.formatTempC : weatherData.current.formatTempF)°\(temperatureUnit.isCelsius ? "C" : "F")")
				}
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 32))

				
				Spacer()
				
				HStack {
					Text(weatherData.current.condition.text)
					Spacer()
					
					Text("H: \(temperatureUnit.isCelsius ? weatherData.forecast.forecastDay[0].day.formattedMaxTempC : weatherData.forecast.forecastDay[0].day.formattedMaxTempF)°")
					
					
					Text("L: \(temperatureUnit.isCelsius ? weatherData.forecast.forecastDay[0].day.formattedMinTempC : weatherData.forecast.forecastDay[0].day.formattedMinTempF)°")
				}
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 16))
			}
			.padding()
			.foregroundColor(.white)
		}
		.frame(height: 110)
		.frame(maxWidth: .infinity)
		.background(Color.gray.opacity(0.5))
		.cornerRadius(10)
		.padding()
    }
}

//#Preview {
//	CityItemView(weatherData: <#WeatherModel#>)
//}
