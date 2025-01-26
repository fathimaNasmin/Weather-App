//
//  SearchView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import SwiftUI

struct SearchView: View {
	@Environment(\.dismiss) var dismiss
	
	@ObservedObject var vm = WeatherViewModel()
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel

	@State private var searchTerm = ""
	@State private var isShowingForecast = false
	
	var geo: GeometryProxy
	let weather: WeatherModel
	
	
    var body: some View {
			
		NavigationStack {
			VStack {
				List {
					ForEach(vm.filteredCountry) { country in
						Button {
							vm.searchText = country.name
							Task {
								await vm.fetchWeatherForecast(for: vm.searchText)
								isShowingForecast = true
							}
						} label: {
							Text("\(country.name), \(country.region), \(country.country)")
								.accentColor(.primary)
						}
					}
				}
				
				Spacer()
				
				Button {
					dismiss()
					vm.searchText = ""
				} label: {
					Image(systemName: "xmark")
						.font(.largeTitle)
						.foregroundColor(.white)
				}

			}
			.searchable(text: $vm.searchText, prompt: "Search")
			.sheet(isPresented: $isShowingForecast) {
				AddForecastSheet(vm: vm, cityCoreDataVM: cityCoreDataVM, weather: weather, geo: geo)
			}
		}
		.ignoresSafeArea()
		.preferredColorScheme(.dark)
		.background(Color.black.opacity(0.9))
    }
		
}

//struct SearchViewPreviewWrapper: View {
//	var body: some View {
//		GeometryReader { geo in
//			SearchView(cityCoreDataVM: CityCoreDataViewModel(), geo: geo)
//		}
//	}
//}
//
//#Preview {
//	SearchViewPreviewWrapper()
//}

