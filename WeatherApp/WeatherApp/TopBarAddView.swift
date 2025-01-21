//
//  TopBarAddView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct TopBarAddView: View {
	@ObservedObject var vm: WeatherViewModel
	@Environment(\.dismiss) var dismiss
	var geo: GeometryProxy
	
    var body: some View {
		// MARK: Top Bar for Add
		VStack {
			HStack{
				Button {
					print("Dismiss the sheet")
					dismiss()
					vm.searchText = ""
				} label: {
					Text("Cancel")
						.accentColor(.primary)
						.font(.custom(Fonts.RobotoCondensedSemiBold, size: 20))
				}
				
				
				Spacer()
				
				VStack {
					Text(vm.forecast.location.name)
						.font(.custom(Fonts.mediumLight, size: 35))
					
					Text(vm.forecast.location.now)
						.font(.custom(Fonts.mediumLight, size: 20))
				}
				
				
				Spacer()
				
				Button {
					// Add to the core data
				} label: {
					Text("Add")
						.accentColor(.primary)
						.font(.custom(Fonts.RobotoCondensedSemiBold, size: 20))
				}
				
				
				
				
			}
			.padding(.horizontal, 25)
			.frame(width: geo.size.width)
			.padding(.top, 65)
			.padding(.bottom, 50)
		}
		.ignoresSafeArea()
    }
}

struct TopBarAddViewWrapper: View {
	var body: some View {
		GeometryReader { geo in
			TopBarAddView(vm: WeatherViewModel(), geo: geo)
		}
	}
}

#Preview {
	TopBarAddViewWrapper()
}
