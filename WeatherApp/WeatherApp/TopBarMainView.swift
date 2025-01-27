//
//  TopBarMainView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct TopBarMainView: View {
	@EnvironmentObject var temperatureUnit: TemperatureUnitState
	@ObservedObject var vm: WeatherViewModel
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	let weather: WeatherModel
	
	@Binding var searchIsPresented: Bool
//	@State var isCelsius: Bool = true
	
	var geo: GeometryProxy
	
    var body: some View {
		VStack {
			HStack{
				Menu {
					Button {
						print("F Pressed")
//						isCelsius = false
						temperatureUnit.isCelsius = false
					} label: {
						Text("Fahrenheit")
						if !temperatureUnit.isCelsius { Image(systemName: "checkmark") }
					}
					Button {
						print("C Pressed")
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
					Text(weather.location.name)
						.font(.custom(Fonts.mediumLight, size: 35))
					
					Text(weather.location.now)
						.font(.custom(Fonts.mediumLight, size: 20))
				}
				
				
				Spacer()
				
				Button {
					searchIsPresented = true
				} label: {
					Image(systemName: "plus")
						.font(.title.weight(.thin))
				}
				.fullScreenCover(isPresented: $searchIsPresented) {
					SearchView(vm: vm, cityCoreDataVM: cityCoreDataVM, geo: geo, weather: weather)
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
