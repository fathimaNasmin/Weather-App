//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		GeometryReader { geo in
			ZStack {
				Gradients.cloudy
				
				VStack {
					// MARK: Top Bar
					HStack{
						Image(systemName: "line.3.horizontal")
							.font(.title.weight(.thin))
						
						Spacer()
						
						VStack {
							Text("Pittsburgh")
								.font(.custom(Fonts.mediumLight, size: 35))
							Text("Sat, 1:40pm")
								.font(.custom(Fonts.mediumLight, size: 20))
							
						}
						
						
						Spacer()
						
						Image(systemName: "plus")
							.font(.title.weight(.thin))
					}
					.padding(.horizontal)
					.padding(.top, 65)
					.padding(.bottom, 50)
					
//					Spacer()
					
					// MARK: Main View
					ScrollView {
						VStack {
							HStack(alignment: .bottom) {
								// cloudy and temp
								VStack {
									HStack {
										Image(systemName: "cloud")
											.font(.largeTitle.weight(.thin))
										
										Text("Cloudy")
										
									}
									.font(.custom(Fonts.mediumLight, size: 40))
									
									HStack(alignment: .top) {
										Text("15")
											.font(.custom(Fonts.mediumLight, size: 120))
										
										Image(systemName: "circle")
											.padding(.top, 10)
											.font(.system(size: 20, weight: .medium))
									}
									.padding(.top, -5)
									.font(.custom(Fonts.mediumLight, size: 40))
								}
								.padding()
								.font(.largeTitle)
								
								// low and high
								VStack {
									HStack {
										Text("21")
											.font(.custom(Fonts.mediumLight, size: 30))
										Image(systemName: "degreesign.celsius")
											.font(.title.weight(.thin))
									}
									Rectangle()
										.fill(.white.opacity(0.5))
										.frame(width: geo.size.width / 4, height: 1)
										
									
									HStack {
										Text("15")
											.font(.custom(Fonts.mediumLight, size: 30))
										Image(systemName: "degreesign.celsius")
											.font(.title.weight(.thin))
									}
								}
								.padding()
								.padding(.bottom, 10)
								.font(.largeTitle)
							}
							
							// TODO: Swift Charts
							
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
									cell(geometry: geo, image: "thermometer.variable", text: "feels like", value: "26°")
									cell(geometry: geo, image: "wind", text: "wind", value: "2 km/h")
									cell(geometry: geo, image: "humidity", text: "humidity", value: "25%")
								}
								GridRow {
									cell(geometry: geo, image: "gauge.with.needle", text: "pressure", value: "30.25 in")
									cell(geometry: geo, image: "eye", text: "visibility", value: "N/A")
									cell(geometry: geo, image: "thermometer.low", text: "dew point", value: "12°")
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
							
							
							// MARK: NEXT 7 DAYS
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
									renderDayForcast(day: "Fri", rainPercent: "30%", image: "cloud.rain", high: "28°", low: "15°")
									renderDayForcast(day: "Sat", rainPercent: nil, image: "sun.rain.fill", high: "32°", low: "20°")
									renderDayForcast(day: "Sun", rainPercent: "30%", image: "cloud.rain", high: "28°", low: "15°")
									renderDayForcast(day: "Mon", rainPercent: "30%", image: "cloud.rain", high: "28°", low: "15°")
									renderDayForcast(day: "Tue", rainPercent: nil, image: "cloud.rain", high: "28°", low: "15°")
									renderDayForcast(day: "Wed", rainPercent: "30%", image: "cloud.rain", high: "28°", low: "15°")
									renderDayForcast(day: "Thu", rainPercent: nil, image: "sun.horizon", high: "36°", low: "25°")
								}
							}


						}
					}
					.padding(.horizontal, 15)
					.scrollIndicators(.hidden)
				}
				.foregroundColor(.white)

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
				.font(.custom(Fonts.RobotoCondensedRegular, size: 18))
				.foregroundColor(.white.opacity(0.5))
				.padding(.bottom, -5)
			Text(value)
					.font(.custom(Fonts.RobotoCondensedRegular, size: 20))
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
		.background(Color.white.opacity(0.1))
		.cornerRadius(8)
	}
	
	private func renderDayForcast(day: String, rainPercent: String?, image:String, high: String, low: String) -> some View {
		VStack(spacing: 5) {
			Text(day)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 20))
				.padding(.bottom, 4)
				.frame(height: 25)


			Text(rainPercent ?? " ")
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 16))
				.foregroundColor(.white.opacity(0.6))
				.padding(.bottom, 0)
				.opacity(rainPercent == nil ? 0 : 1)
				.frame(height: 20)

			
			Image(systemName: image)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 22))
				.padding(.bottom, 8)
				.frame(height: 25)
			
			Text(high)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 18))
				.padding(.bottom, -2)
				.frame(height: 20)
			
			Rectangle()
				.fill(.white.opacity(0.5))
				.frame(height: 1)
			
			Text(low)
				.font(.custom(Fonts.RobotoCondensedSemiBold, size: 18))
				.padding(.bottom, 6)
				.frame(height: 20)
		}
		.frame(width: 45)
	}
}

#Preview {
    ContentView()
}
