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
	@StateObject var searchVM = WeatherViewModel()

	@State private var searchTerm = ""
	@State private var isShowingForecast = false
	@Binding var selectedCityTab: String
	
	var geo: GeometryProxy
	let weather: WeatherModel
	
	
    var body: some View {
			
		NavigationStack {
			VStack {
				CityListView(cityCoreDataVM: cityCoreDataVM, selectedCityTab: $selectedCityTab)

			}
			.searchable(text: $searchVM.searchText, prompt: "Search")
			.navigationTitle("Search")
			.sheet(isPresented: $isShowingForecast) {
				AddForecastSheet(vm: searchVM, cityCoreDataVM: cityCoreDataVM, weather: weather, geo: geo)
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


//				List {
//					ForEach(searchVM.filteredCountry) { country in
//						Button {
//							searchVM.searchText = country.name
//							Task {
//								await searchVM.fetchWeatherForecast(for: searchVM.searchText)
//								isShowingForecast = true
//							}
//						} label: {
//							Text("\(country.name), \(country.region), \(country.country)")
//								.accentColor(.primary)
//						}
//					}
//				}
