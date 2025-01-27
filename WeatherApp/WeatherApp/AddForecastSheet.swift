//
//  AddForecastSheet.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct AddForecastSheet: View {
	@ObservedObject var vm: WeatherViewModel
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	
	let weather: WeatherModel
	
	var geo: GeometryProxy
	
    var body: some View {
		GeometryReader { geo in
			ZStack {
				if let weatherCondition = WeatherCondition(rawValue: vm.forecast.current.condition.text) {
					weatherCondition.backgroundGradient
				} else {
					Color.gray.opacity(0.4)
				}
				
				
				
				VStack {
					// MARK: Top Bar
					TopBarAddView(vm: vm, cityCoreDataVM: cityCoreDataVM, geo: geo)
					
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

//struct AddForecastSheetWrapper: View {
//	var body: some View {
//		GeometryReader { geo in
//			AddForecastSheet(cityCoreDataVM: CityCoreDataViewModel(), geo: geo)
//		}
//	}
//}
//
//#Preview {
//	AddForecastSheetWrapper()
//}

