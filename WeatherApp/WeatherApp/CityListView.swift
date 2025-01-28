//
//  CityListView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/27/25.
//

import SwiftUI

struct CityListView: View {
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	
    var body: some View {
		ScrollView {
			ForEach(Array(cityCoreDataVM.storedCityWeatherData), id: \.key) { name, data in
				CityItemView(weatherData: data)
					.padding(.vertical, -10)
				
			}
		}
    }
}

#Preview {
	CityListView(cityCoreDataVM: CityCoreDataViewModel())
}
