//
//  CityListView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/27/25.
//

import SwiftUI

struct CityListView: View {
	@Environment(\.dismiss) var dismiss
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	@Binding var selectedCityTab: String
	
    var body: some View {
			List {
				ForEach(Array(cityCoreDataVM.storedCityWeatherData), id: \.key) { name, data in
					CityItemView(weatherData: data)
						.padding(.vertical, -10)
						.padding(.horizontal, -20)
						.listRowSeparator(.hidden)
						.onTapGesture {
							selectedCityTab = data.location.name
							dismiss()
						}
						.transition(.opacity)
				}
				.onDelete { indexSet in
					Task {
						await cityCoreDataVM.deleteCity(indexSet: indexSet)
					}
				}

				.listRowBackground(Color.clear)
			}
			.listStyle(.plain)
			.animation(.easeInOut(duration: 0.7), value: cityCoreDataVM.storedCityNames)
    }
}

#Preview {
	@Previewable @State var selectedCityTab: String = ""
	CityListView(cityCoreDataVM: CityCoreDataViewModel(), selectedCityTab: $selectedCityTab)
}
