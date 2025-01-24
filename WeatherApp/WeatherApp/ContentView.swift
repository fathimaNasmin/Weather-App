//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI

struct ContentView: View {
	@State private var searchIsPresented = false
	@ObservedObject var vm: WeatherViewModel
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
					
					// MARK: MAIN VIEW
					MainContentView(vm: vm, geo: geo)
					
				}
				.foregroundColor(.white)
				.frame(maxWidth: geo.size.width - 10)
				.padding(.horizontal, 10)
				.padding(.bottom, 40)
			}
			.ignoresSafeArea()
			
			// MARK: LOADING SPINNER
			// Loading Spinner Overlay
			if vm.isLoading {
				ZStack {
					Color.black.opacity(0.5)
						.ignoresSafeArea()
					
					VStack {
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: .white))
							.scaleEffect(2)
						
						Text("Loading Weather...")
							.font(.title3)
							.foregroundColor(.white)
							.padding(.top, 8)
					}
					.padding()
					.padding(.vertical, 20)
					.background(Color.black.opacity(0.7))
					.cornerRadius(15)
				}
			}

			
		}

    }
	
}

#Preview {
	ContentView(vm: WeatherViewModel())
}
