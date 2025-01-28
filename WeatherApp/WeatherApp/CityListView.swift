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
		ScrollView {
			ForEach(Array(cityCoreDataVM.storedCityWeatherData), id: \.key) { name, data in
				CityItemView(weatherData: data)
					.padding(.vertical, -10)
					.onTapGesture {
						selectedCityTab = data.location.name
						dismiss()
					}
				
			}
		}
    }
}

#Preview {
	@Previewable @State var selectedCityTab: String = ""
	CityListView(cityCoreDataVM: CityCoreDataViewModel(), selectedCityTab: $selectedCityTab)
}
