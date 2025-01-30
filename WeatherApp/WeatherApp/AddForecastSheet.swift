//
//  AddForecastSheet.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct AddForecastSheet: View {
	@ObservedObject var searchVM: WeatherViewModel
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	
	let weather: WeatherModel
	
	var geo: GeometryProxy
	
    var body: some View {
		GeometryReader { geo in
			ZStack {
				if let weatherCondition = WeatherCondition(rawValue: searchVM.forecast.current.condition.text) {
					weatherCondition.backgroundGradient
				} else {
					Color.gray.opacity(0.4)
				}
				
				
				
				VStack {
					// MARK: Top Bar
					TopBarAddView(cityCoreDataVM: cityCoreDataVM, geo: geo)
					
					MainContentView(geo: geo, weather: weather)
					
				}
				.foregroundColor(.white)
				.frame(maxWidth: geo.size.width / 1.1)
				.padding(.horizontal, 10)
				.padding(.bottom, 40)
			}
			
			.ignoresSafeArea()
		}

    }
}
