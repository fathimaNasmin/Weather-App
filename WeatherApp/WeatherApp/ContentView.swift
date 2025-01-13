//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		GeometryReader { geo in
			ZStack {
				Gradients.cloudy
				
				VStack {
					HStack(alignment: .bottom) {
						// cloudy and temp
						VStack {
							HStack {
								Image(systemName: "cloud")
								Text("Cloudy")
							}
							HStack(alignment: .top) {
								Text("15")
									.font(.system(size: 96))
								Image(systemName: "circle")
									.padding(.top, 10)
									.font(.system(size: 20))
							}
							.padding(.top, -5)
						}
						.padding()
						.font(.largeTitle)
						// low and high
						VStack {
							HStack {
								Text("21")
									.padding(.bottom, -1)
								Image(systemName: "degreesign.celsius")
									.font(.title)
							}
							Rectangle()
								.frame(width: geo.size.width / 4, height: 1)
							
							HStack {
								Text("15")
									.padding(.top, -1)
								Image(systemName: "degreesign.celsius")
									.font(.title)
							}
						}
						.padding()
						.padding(.bottom, 10)
						.font(.largeTitle)
					}
				}
				.foregroundColor(.white)
			}
			.ignoresSafeArea()
		}

    }
}

#Preview {
    ContentView()
}
