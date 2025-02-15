//
//  MainContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct MainContentView: View {
	@EnvironmentObject var temperatureUnit: TemperatureUnitState
	var geo: GeometryProxy
	let weather: WeatherModel
	
    var body: some View {
		VStack {
			// MARK: Main View
			ScrollView {
				VStack {
					HStack(alignment: .bottom) {
						// cloudy and temp
						
						VStack {
							HStack {
								if let weatherCondition = WeatherCondition(rawValue: weather.current.condition.text) {
									Image(systemName: weatherCondition.sfSymbol)
										.font(.largeTitle.weight(.thin))
										.imageScale(.large)
									//												.padding(.horizontal, 20)
									
									
								} else {
									Image(systemName: "questionmark")
										.font(.largeTitle.weight(.thin))
								}
								
								
								Text(weather.current.condition.text)
									.font(.custom(Fonts.mediumLight,
												  size:weather.current.condition.text.count < 10 ? 35 : 28)
									)
									.fixedSize(horizontal: false, vertical: true)
									.multilineTextAlignment(.center)
									.minimumScaleFactor(0.5)
								
							}
							
							HStack(alignment: .top) {
								Text("\(temperatureUnit.isCelsius ? weather.current.formatTempC : weather.current.formatTempF)°")
									.font(.custom(Fonts.mediumLight, size: 100))
							}
							.padding(.top, -5)
							.font(.custom(Fonts.mediumLight, size: 40))
						}
						.frame(width: geo.size.width / 2)
						.padding()
						.font(.largeTitle)
						
						
						// low and high
						VStack {
							HStack {
								Text(temperatureUnit.isCelsius ? weather.forecast.forecastDay[0].day.formattedMaxTempC : weather.forecast.forecastDay[0].day.formattedMaxTempF)
									.font(.custom(Fonts.mediumLight, size: 30))
									.padding(.bottom, -1)
								Image(systemName: temperatureUnit.isCelsius ? "degreesign.celsius" : "degreesign.fahrenheit")
									.font(.title.weight(.thin))
							}
							Rectangle()
								.fill(.white.opacity(0.5))
								.frame(width: geo.size.width / 4, height: 1)
							
							
							HStack {
								Text(temperatureUnit.isCelsius ?  weather.forecast.forecastDay[0].day.formattedMinTempC : weather.forecast.forecastDay[0].day.formattedMinTempF)
									.font(.custom(Fonts.mediumLight, size: 30))
									.padding(.top, -1)
								
								Image(systemName: temperatureUnit.isCelsius ? "degreesign.celsius" : "degreesign.fahrenheit")
									.font(.title.weight(.thin))
							}
						}
						.padding(.trailing, 20)
						.padding(.bottom, 20)
						.font(.largeTitle)
					}
					.frame(width: geo.size.width)
					
					// MARK: Swift Charts
					
					HourlyWeatherChartView(hourlyData: weather.forecast.forecastDay[0].hourly)
						.frame(width: geo.size.width)
						.padding(.horizontal, 12)
					
					// MARK: Details
					HStack{
						Text("details".uppercased())
							.font(.custom(Fonts.semiCondensedExtraLight, size: 18))
							.padding(.trailing, 7)
						Rectangle()
							.fill(.white.opacity(0.5))
							.frame(height: 1)
					}
					.padding()
					
					// Grid
					Grid(horizontalSpacing: 12, verticalSpacing: 12) {
						GridRow {
							cell(geometry: geo, image: "thermometer.variable", text: "feels like", value: "\(temperatureUnit.isCelsius ? weather.current.feelslikeC : weather.current.feelslikeF)°")
							cell(geometry: geo, image: "wind", text: "wind", value: "\(weather.current.windKph) km/h")
							cell(geometry: geo, image: "humidity", text: "humidity", value: "\(weather.current.humidity)%")
						}
						GridRow {
							cell(geometry: geo, image: "gauge.with.needle", text: "pressure", value: "\(weather.current.pressureIn) in")
							cell(geometry: geo, image: "eye", text: "visibility", value: "\(weather.current.visibility)")
							cell(geometry: geo, image: "thermometer.low", text: "dew point", value: "\(weather.current.dewpointC)°")
						}
					}
					
					
					// MARK: CHANCE OF RAIN
					HStack{
						Text("chance of rain".uppercased())
							.font(.custom(Fonts.semiCondensedExtraLight, size: 18))
							.padding(.trailing, 7)
						Rectangle()
							.fill(.white.opacity(0.5))
							.frame(height: 1)
					}
					.padding()
					
					// MARK: swift charts
					ChanceOfRainChartView(hourlyRainData: weather.forecast.forecastDay[0].hourly)
					
					
					
					// MARK: NEXT 7 DAYS
					VStack {
						HStack{
							Text("next 7 days".uppercased())
								.font(.custom(Fonts.semiCondensedExtraLight, size: 18))
								.padding(.trailing, 7)
							Rectangle()
								.fill(.white.opacity(0.5))
								.frame(height: 1)
						}
						.padding()
						// Grid
						Grid {
							GridRow {
								ForEach(weather.forecast.forecastDay.suffix(from: 2), id:\.date) { data in
									renderDayForcast(geometry: geo, day: data.formattedDateEpoch, rainPercent: data.day.dailyChanceOfRain, image: data.day.condition.trimmedText, high: "\(temperatureUnit.isCelsius ?  data.day.formattedMaxTempC : data.day.formattedMaxTempF )°", low: "\(temperatureUnit.isCelsius ? data.day.formattedMinTempC : data.day.formattedMinTempF )°")
								}
								
								
							}
						}
						.frame(width: geo.size.width)
					}
					.frame(width: geo.size.width)
					.padding()
					.padding(.horizontal, 30)
					
					
				}
				.frame(width: geo.size.width / 1.1)
				.padding(.horizontal, 20)
			}
			.frame(width: geo.size.width)
			.padding(.horizontal, 15)
			.scrollIndicators(.hidden)
		}
		.foregroundColor(.white)
		.frame(maxWidth: geo.size.width / 1.1)
		.padding(.horizontal, 10)
		.padding(.bottom, 40)
    }
	
	private func cell(geometry: GeometryProxy, image: String, text: String, value: String) -> some View {
		VStack {
			Image(systemName: image)
				.font(.title2)
				.padding(.bottom, 5)
			Text(text.capitalized)
				.font(.custom(Fonts.RobotoCondensedRegular, size: 16))
				.foregroundColor(.white.opacity(0.5))
				.padding(.bottom, -5)
			Text(value)
				.font(.custom(Fonts.RobotoCondensedRegular, size: 18))
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
		.background(Color.white.opacity(0.1))
		.cornerRadius(8)
	}
	
	private func renderDayForcast(geometry: GeometryProxy, day: String, rainPercent: Int, image:String, high: String, low: String) -> some View {
		VStack(spacing: 5) {
			Text(day)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 15))
				.frame(height: 25)
			
			
			Text(rainPercent > 0 ? "\(rainPercent)%" : "")
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 12))
				.foregroundColor(.white.opacity(0.6))
				.padding(.bottom, 0)
				.opacity(rainPercent > 0 ? 1 : 0)
				.frame(height: 20)
			
			if let weatherCondition = WeatherCondition(rawValue:image) {
				
				Image(systemName: weatherCondition.sfSymbol)
					.font(.custom(Fonts.RobotoCondensedSemiBold, size: 18))
					.padding(.bottom, 6)
					.frame(height: 25)
			} else {
				Image(systemName: "questionmark")
					.font(.largeTitle)
					.foregroundColor(.clear)
					.padding(.bottom, 6)
					.frame(height: 25)
			}
			
			Text(high)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 16))
				.padding(.bottom, -2)
				.frame(height: 20)
			
			Rectangle()
				.fill(.white.opacity(0.5))
				.frame(width: 30, height: 1)
			
			Text(low)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 15))
				.opacity(0.7)
				.padding(.bottom, 6)
				.frame(height: 20)
		}
		.frame(width: geometry.size.width / 7)
		.padding(.horizontal, -5)
	}

}


//struct MainContentPreviewWrapper: View {
//	var body: some View {
//		GeometryReader { geo in
//			MainContentView(geo: geo)
//		}
//	}
//}
//
//#Preview {
//	MainContentPreviewWrapper()
//}
