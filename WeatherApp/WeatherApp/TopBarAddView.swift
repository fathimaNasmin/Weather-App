//
//  TopBarAddView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct TopBarAddView: View {
	@EnvironmentObject var weatherVM: WeatherViewModel
	@ObservedObject var cityCoreDataVM: CityCoreDataViewModel
	@ObservedObject var searchVM: WeatherViewModel
	
	@Environment(\.dismiss) var dismiss
	var geo: GeometryProxy
	
    var body: some View {
		// MARK: Top Bar for Add
		VStack {
			HStack{
				// Cancel button
				Button {
					dismiss()
				} label: {
					Text("Cancel")
						.accentColor(.primary)
						.font(.custom(Fonts.RobotoCondensedSemiBold, size: 20))
				}
				
				
				Spacer()
				
				VStack {
					Text(searchVM.forecast.location.name)
						.font(.custom(Fonts.mediumLight, size: 35))
					
					Text(searchVM.forecast.location.now)
						.font(.custom(Fonts.mediumLight, size: 20))
				}
				
				
				Spacer()
				
				Button {
					Task {
						await cityCoreDataVM.addCityName(cityName: searchVM.searchText)
					}
					dismiss()
				} label: {
					Text(cityCoreDataVM.storedCityNames.contains(searchVM.searchText) ? "" : "Add")
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

//struct TopBarAddViewWrapper: View {
//	var body: some View {
//		GeometryReader { geo in
//			TopBarAddView(cityCoreDataVM: CityCoreDataViewModel(), geo: geo)
//		}
//	}
//}
//
//#Preview {
//	TopBarAddViewWrapper()
//}
