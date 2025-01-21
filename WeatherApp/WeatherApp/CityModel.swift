//
//  CityModel.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/19/25.
//

import Foundation

struct CityModel: Decodable, Identifiable {
	let id: Int
	let name: String
	let region: String
	let country: String
}
