//
//  SearchView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import SwiftUI

struct SearchView: View {
	@Environment(\.dismiss) var dismiss
	
	@ObservedObject var vm: WeatherViewModel
	@State private var searchTerm = ""
	
	
    var body: some View {
			
		NavigationStack {
			VStack {
				List {
					ForEach(vm.filteredCountry) { country in
						Button {
							vm.searchText = country.name
						} label: {
							Text("\(country.name), \(country.region), \(country.country)")
								.accentColor(.primary)
						}
					}
				}
				
				Spacer()
				
				Button {
					dismiss()
				} label: {
					Image(systemName: "xmark")
						.font(.largeTitle)
						.foregroundColor(.white)
				}

			}
			.searchable(text: $vm.searchText, prompt: "Search")
		}
		.ignoresSafeArea()
		.preferredColorScheme(.dark)
		.background(Color.black.opacity(0.9))
    }
		
}

#Preview {
	SearchView(vm: WeatherViewModel())
}
