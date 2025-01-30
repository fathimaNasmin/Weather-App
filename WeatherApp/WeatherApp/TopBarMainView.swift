//
//  TopBarMainView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct TopBarMainView: View {
	@EnvironmentObject var temperatureUnit: TemperatureUnitState
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
		
	@Binding var searchIsPresented: Bool
	@Binding var selectedCityTab: String
	
	let weather: WeatherModel
	let isCurrentLocation: Bool?
	var geo: GeometryProxy
	
    var body: some View {
		VStack {
			HStack{
				Menu {
					Button {
						temperatureUnit.isCelsius = false
					} label: {
						Text("Fahrenheit")
						if !temperatureUnit.isCelsius { Image(systemName: "checkmark") }
					}
					Button {
						temperatureUnit.isCelsius = true
					} label: {
						Text("Celsius")
						if temperatureUnit.isCelsius { Image(systemName: "checkmark") }
					}

				} label: {
					Image(systemName: "ellipsis")
						.font(.title.weight(.thin))
				}
				
				Spacer()
				
				VStack {
					// Symbol that shows current location
					if isCurrentLocation != nil {
						HStack {
							Image(systemName: "location.fill")
							Text("Current Location")
						}
						.font(.custom(Fonts.semiCondensedExtraLight, size: 15))
						.padding(.bottom, 3)
						
					}
					
					Text(weather.location.name)
						.font(.custom(Fonts.mediumLight, size: 35))
					
					Text(weather.location.now)
						.font(.custom(Fonts.mediumLight, size: 20))
				}
				
				
				Spacer()
				
				Button {
					print("Plus button tapped")
					if !searchIsPresented {
						searchIsPresented = true
					}
				} label: {
					Image(systemName: "plus")
						.font(.title.weight(.thin))
				}
				.sheet(isPresented: $searchIsPresented) {
					SearchView(cityCoreDataVM: cityCoreDataVM, selectedCityTab: $selectedCityTab, geo: geo, weather: weather)
				}
				
				
				
			}
			.padding(.horizontal, 25)
			.frame(width: geo.size.width)
			.padding(.top, 65)
			.padding(.bottom, 50)

		}
    }
}


//// For Preview
//struct TopBarAddMainWrapper: View {
//	@Binding var previewSearchIsPresented: Bool
//	let weather: WeatherModel
//	
//	var body: some View {
//		GeometryReader { geo in
//			TopBarMainView(weather: weather, searchIsPresented: $previewSearchIsPresented, geo: geo)
//		}
//	}
//}
//
//#Preview {
//	@Previewable @State var previewSearchIsPresented = false
//	TopBarAddMainWrapper(previewSearchIsPresented: $previewSearchIsPresented, weather: WeatherModel())
//}
