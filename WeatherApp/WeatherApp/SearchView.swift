//
//  SearchView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import SwiftUI

struct SearchView: View {
	@Environment(\.dismiss) var dismiss
	
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	@StateObject var searchVM = WeatherViewModel()

	@State private var searchTerm = ""
	@State private var isShowingForecast = false
	@Binding var selectedCityTab: String
	
	var geo: GeometryProxy
	let weather: WeatherModel
	
	
    var body: some View {
			
		NavigationStack {

			ZStack {
			VStack {
				CityListView(cityCoreDataVM: cityCoreDataVM, selectedCityTab: $selectedCityTab)
				
			}
			.navigationTitle("Search")
			.sheet(isPresented: $isShowingForecast) {
				AddForecastSheet(searchVM: searchVM, cityCoreDataVM: cityCoreDataVM, weather: weather, geo: geo)
			}
				
			SearchingView(searchVM: searchVM, isShowingForecast: $isShowingForecast)
				.searchable(text: $searchVM.searchText, prompt: "Search")
		}

		}
		.ignoresSafeArea()
		.preferredColorScheme(.dark)
		.background(Color.black.opacity(0.9))
    }
		
}

struct SearchingView: View {
	@Environment(\.isSearching) private var isSearching
	@ObservedObject var searchVM: WeatherViewModel
	@State private var searchTerm = ""
	@Binding var isShowingForecast: Bool
	
	var body: some View {
		ZStack {
			if isSearching {
				Color.black.opacity(0.4)
					.edgesIgnoringSafeArea(.all) // Dim the entire view
					.transition(.opacity)
					.animation(.easeInOut, value: searchTerm) // Smooth transition

					VStack {
						List {
							ForEach(searchVM.filteredCountry) { country in
								Button {
									searchVM.searchText = country.name
									Task {
										await searchVM.fetchWeatherForecast(for: searchVM.searchText)
										isShowingForecast = true
									}
								} label: {
									Text("\(country.name), \(country.region), \(country.country)")
										.accentColor(.primary)
								}
							}
						}
						Spacer()
					}
			}
		}
	}
}

struct SearchViewPreviewWrapper: View {
	
	var body: some View {
		GeometryReader { geo in
			SearchView(cityCoreDataVM: CityCoreDataViewModel(), selectedCityTab: .constant("spain"), geo: geo, weather: WeatherModel.sample)
		}
	}
}

#Preview {
	SearchViewPreviewWrapper()
}



