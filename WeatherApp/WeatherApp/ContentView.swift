//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var vm = WeatherViewModel()
	@State private var searchIsPresented = false
	//
    var body: some View {
		GeometryReader { geo in
			ZStack {
				if let weatherCondition = WeatherCondition(rawValue: vm.forecast.current.condition.text) {
					weatherCondition.backgroundGradient
				} else {
					Color.gray.opacity(0.4)
				}
				
				VStack {
					// MARK: Top Bar
					HStack{
						Image(systemName: "line.3.horizontal")
							.font(.title.weight(.thin))
						
						Spacer()
						
						VStack {
							Text(vm.forecast.location.name)
								.font(.custom(Fonts.mediumLight, size: 35))
							
							Text(vm.forecast.location.now)
								.font(.custom(Fonts.mediumLight, size: 20))
						}
						
						
						Spacer()
						
						Button {
							print("button clicked")
							searchIsPresented = true
						} label: {
							Image(systemName: "plus")
								.font(.title.weight(.thin))
						}
						.fullScreenCover(isPresented: $searchIsPresented) {
							SearchView()
						}

						
						
					}
					.padding(.horizontal, 25)
					.frame(width: geo.size.width)
					.padding(.top, 65)
					.padding(.bottom, 50)
					
					
					// MARK: Main View
					ScrollView {
						VStack {
							HStack(alignment: .bottom) {
								// cloudy and temp
								
								VStack {
									HStack {
										if let weatherCondition = WeatherCondition(rawValue: vm.forecast.current.condition.text) {
											Image(systemName: weatherCondition.sfSymbol)
												.font(.largeTitle.weight(.thin))
												.imageScale(.large)
//												.padding(.horizontal, 20)
											
											
										} else {
											Image(systemName: "questionmark")
												.font(.largeTitle.weight(.thin))
										}
										
										
										Text(vm.forecast.current.condition.text)
											.font(.custom(Fonts.mediumLight,
														  size:vm.forecast.current.condition.text.count < 10 ? 35 : 28)
											)
											.fixedSize(horizontal: false, vertical: true)
											.multilineTextAlignment(.center)
											.minimumScaleFactor(0.5)
										
									}
									
									HStack(alignment: .top) {
										Text("\(vm.forecast.current.formatTempC)°")
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
										Text(vm.forecast.forecast.forecastDay[0].day.formattedMaxTempC)
											.font(.custom(Fonts.mediumLight, size: 30))
											.padding(.bottom, -1)
										Image(systemName: "degreesign.celsius")
											.font(.title.weight(.thin))
									}
									Rectangle()
										.fill(.white.opacity(0.5))
										.frame(width: geo.size.width / 4, height: 1)
										
									
									HStack {
										Text(vm.forecast.forecast.forecastDay[0].day.formattedMinTempC)
											.font(.custom(Fonts.mediumLight, size: 30))
											.padding(.top, -1)
										
										Image(systemName: "degreesign.celsius")
											.font(.title.weight(.thin))
									}
								}
								.padding(.trailing, 20)
								.padding(.bottom, 20)
								.font(.largeTitle)
							}
							.frame(width: geo.size.width)
							
							// MARK: Swift Charts
							
							HourlyWeatherChartView(hourlyData: vm.forecast.forecast.forecastDay[0].hourly)
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
									cell(geometry: geo, image: "thermometer.variable", text: "feels like", value: "\(vm.forecast.current.feelslikeC)°")
									cell(geometry: geo, image: "wind", text: "wind", value: "\(vm.forecast.current.windKph) km/h")
									cell(geometry: geo, image: "humidity", text: "humidity", value: "\(vm.forecast.current.humidity)%")
								}
								GridRow {
									cell(geometry: geo, image: "gauge.with.needle", text: "pressure", value: "\(vm.forecast.current.pressureIn) in")
									cell(geometry: geo, image: "eye", text: "visibility", value: "\(vm.forecast.current.visibility)")
									cell(geometry: geo, image: "thermometer.low", text: "dew point", value: "\(vm.forecast.current.dewpointC)°")
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
							
							// TODO: swift charts
							ChanceOfRainChartView(hourlyRainData: vm.forecast.forecast.forecastDay[0].hourly)
							
							
							
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
										ForEach(vm.forecast.forecast.forecastDay.suffix(from: 2), id:\.date) { data in
											renderDayForcast(geometry: geo, day: data.formattedDateEpoch, rainPercent: data.day.dailyChanceOfRain, image: data.day.condition.trimmedText, high: "\(data.day.formattedMaxTempC)°", low: "\(data.day.formattedMinTempC)°")
										}
										
										
									}
								}
								.frame(width: geo.size.width)
							}
							.frame(width: geo.size.width)
							.padding()
							.padding(.horizontal, 30)


						}
						.frame(width: geo.size.width - 20)
						.padding(.horizontal, 20)
					}
					.frame(width: geo.size.width)
					.padding(.horizontal, 15)
					.scrollIndicators(.hidden)
				}
				.foregroundColor(.white)
				.frame(maxWidth: geo.size.width - 10)
				.padding(.horizontal, 10)
				.padding(.bottom, 40)
			}

			.ignoresSafeArea()
		}

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

#Preview {
    ContentView()
}
