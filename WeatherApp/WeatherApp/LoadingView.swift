//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/25/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
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

#Preview {
    LoadingView()
}
