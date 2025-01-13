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
					// MARK: Top Bar
					HStack{
						Image(systemName: "line.3.horizontal")
							.font(.title.weight(.thin))
						
						Spacer()
						
						VStack {
							Text("Pittsburgh")
								.font(.custom(Fonts.mediumLight, size: 35))
							Text("Sat, 1:40pm")
								.font(.custom(Fonts.mediumLight, size: 20))
							
						}
						
						
						Spacer()
						
						Image(systemName: "plus")
							.font(.title.weight(.thin))
					}
					.padding(.horizontal)
					.padding(.top, 65)
					
//					Spacer()
					
					// MARK: Main View
					ScrollView {
						VStack {
							HStack(alignment: .bottom) {
								// cloudy and temp
								VStack {
									HStack {
										Image(systemName: "cloud")
											.font(.largeTitle.weight(.thin))
										
										Text("Cloudy")
										
									}
									.font(.custom(Fonts.mediumLight, size: 40))
									
									HStack(alignment: .top) {
										Text("15")
											.font(.custom(Fonts.mediumLight, size: 120))
										
										Image(systemName: "circle")
											.padding(.top, 10)
											.font(.system(size: 20))
											.font(.largeTitle.weight(.thin))
									}
									.padding(.top, -5)
									.font(.custom(Fonts.mediumLight, size: 40))
								}
								.padding()
								.font(.largeTitle)
								
								// low and high
								VStack {
									HStack {
										Text("21")
											.padding(.bottom, -1)
											.font(.custom(Fonts.mediumLight, size: 40))
										Image(systemName: "degreesign.celsius")
											.font(.largeTitle.weight(.thin))
									}
									Rectangle()
										.frame(width: geo.size.width / 4, height: 1)
									
									HStack {
										Text("15")
											.padding(.top, -1)
											.font(.custom(Fonts.mediumLight, size: 40))
										Image(systemName: "degreesign.celsius")
											.font(.largeTitle.weight(.thin))
									}
								}
								.padding()
								.padding(.bottom, 10)
								.font(.largeTitle)
							}
						}
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
