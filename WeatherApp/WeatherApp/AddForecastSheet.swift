//
//  AddForecastSheet.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct AddForecastSheet: View {
	@ObservedObject var vm: WeatherViewModel
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
					TopBarAddView(vm: vm, geo: geo)
					
					MainContentView(vm: vm, geo: geo)
					
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

struct AddForecastSheetWrapper: View {
	var body: some View {
		GeometryReader { geo in
			AddForecastSheet(vm: WeatherViewModel(), geo: geo)
		}
	}
}

#Preview {
	AddForecastSheetWrapper()
}

