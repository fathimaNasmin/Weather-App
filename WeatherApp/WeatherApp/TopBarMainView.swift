//
//  TopBarMainView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/21/25.
//

import SwiftUI

struct TopBarMainView: View {
	@ObservedObject var vm: WeatherViewModel
	@Binding var searchIsPresented: Bool
	
	var geo: GeometryProxy
	
    var body: some View {
		VStack {
			HStack{
				Image(systemName: "line.3.horizontal")
					.font(.title.weight(.thin))
				
				Spacer()
				
				VStack {
					Text(vm.forecast.location.name)
						.font(.custom(Fonts.mediumLight, size: 35))
					
					Text(vm.forecast.location.now)
						.font(.custom(Fonts.mediumLight, size: 20))
				}
				
				
				Spacer()
				
				Button {
					searchIsPresented = true
				} label: {
					Image(systemName: "plus")
						.font(.title.weight(.thin))
				}
				.fullScreenCover(isPresented: $searchIsPresented) {
					SearchView(vm: vm, geo: geo)
				}
				
				
				
			}
			.padding(.horizontal, 25)
			.frame(width: geo.size.width)
			.padding(.top, 65)
			.padding(.bottom, 50)

		}
    }
}

struct TopBarAddMainWrapper: View {
	@Binding var previewSearchIsPresented: Bool
	var body: some View {
		GeometryReader { geo in
			TopBarMainView(vm: WeatherViewModel(), searchIsPresented: $previewSearchIsPresented, geo: geo)
		}
	}
}

#Preview {
	@Previewable @State var previewSearchIsPresented = false
	TopBarAddMainWrapper(previewSearchIsPresented: $previewSearchIsPresented)
}
