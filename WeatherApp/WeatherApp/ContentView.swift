//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var vm = WeatherViewModel()
	@State private var searchIsPresented = false
	//
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
					TopBarMainView(vm: vm, searchIsPresented: $searchIsPresented, geo: geo)
					
					MainContentView(vm: vm, geo: geo)
					
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

#Preview {
    ContentView()
}
