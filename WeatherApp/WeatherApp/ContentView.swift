//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var vm: WeatherViewModel
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	@State private var searchIsPresented = false

	let weather: WeatherModel

    var body: some View {
		GeometryReader { geo in
			ZStack {
				if let weatherCondition = WeatherCondition(rawValue: weather.current.condition.text) {
					weatherCondition.backgroundGradient
				} else {
					Color.gray.opacity(0.4)
				}
				
				
				
				VStack {
					// MARK: Top Bar
					TopBarMainView(vm: vm, cityCoreDataVM: cityCoreDataVM, weather: weather, searchIsPresented: $searchIsPresented, geo: geo)
					
					// MARK: MAIN VIEW
					MainContentView(geo: geo, weather: weather)
					
				}
				.foregroundColor(.white)
				.frame(maxWidth: geo.size.width - 10)
				.padding(.horizontal, 10)
				.padding(.bottom, 40)
			}
			.ignoresSafeArea()
			
		}

	}
}

//#Preview {
//	ContentView(cityCoreDataVM: CityCoreDataViewModel())
//}
