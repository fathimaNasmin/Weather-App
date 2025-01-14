//
//  SearchView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import SwiftUI

struct SearchView: View {
	@Environment(\.dismiss) var dismiss
	@State private var searchTerm = ""
	
    var body: some View {
			
		NavigationStack {
			VStack {
				List {
					Text("Item 1")
					Text("Item 2")
					Text("Item 3")
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
			.searchable(text: $searchTerm, prompt: "Search")
		}
		.ignoresSafeArea()
		.preferredColorScheme(.dark)
		.background(Color.black.opacity(0.9))
    }
		
}

#Preview {
    SearchView()
}
