//
//  Constants.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import Foundation
import SwiftUI

enum Fonts {
	static let mediumLight = "Roboto-ExtraLight"
	static let semiCondensedExtraLight = "Roboto_SemiCondensed-ExtraLight"
	static let RobotoCondensedRegular = "Roboto_Condensed-Regular"
	static let RobotoCondensedSemiBold = "Roboto_Condensed-SemiBold"
}


enum WeatherCondition: String {
	case sunny = "Sunny"
	case clear = "Clear"
	
	case partlyCloudy = "Partly cloudy"
	case cloudy = "Cloudy"
	case overcast = "Overcast"
	case mist = "Mist"
	case fog = "Fog"
	case freezingFog = "Freezing Fog"
	
	case patchyRainPossible = "Patchy rain possible"
	case patchyLightRain = "Patchy light rain"
	case lightRain = "Light rain"
	case moderateRainTimes = "Moderate rain at times"
	case moderateRain = "Moderate rain"
	case heavyRainTimes = "Heavy rain at times"
	case heavyRain = "Heavy rain"
	case moderateOrHeavyFreezingRain = "Moderate or heavy freezing rain"
	case lightRainShower = "Light rain shower"
	case moderateOrHeavyRainShower = "Moderate or heavy rain shower"
	case torrentialRainShower = "Torrential rain shower"
	case patchyLightRainWithThunder = "Patchy light rain with thunder"
	case moderateOrHeavyRainWithThunder = "Moderate or heavy rain with thunder"
	
	case patchySnowPossible = "Patchy snow possible"
	case lightSnow = "Light snow"
	case blowingSnow = "Blowing snow"
	case moderateOrHeavySnowShowers = "Moderate or heavy snow showers"
	

	case thunderyOutbreaksPossible = "Thundery outbreaks possible"
	case blizzard = "Blizzard"

	case patchyLightdrizzle = "Patchy light drizzle"
	case drizzle = "Light drizzle"
	case freezingDrizzle = "Freezing drizzle"
	case heavyFreezingDrizzle = "Heavy freezing drizzle"

	case patchySleetPossible = "Patchy sleet possible"
	case lightSleet = "Light sleet"
	case moderateOrHeavySleet = "Moderate or heavy sleet"
	case moderateOrHeavySleetShower = "Moderate or heavy sleet showers"
	
	case patchyLightSnow = "Patchy light snow"
	case moderateSnow = "Moderate snow"
	case patchyHeavySnow = "Patchy heavy snow"
	case heavySnow = "Heavy snow"
	
	case icePellets = "Ice pellets"
	case lightShowersOfIcePellets = "Light showers of ice pellets"
	case moderateHeavyShowersIcePellets = "Moderate or heavy showers of ice pellets"

	case patchyLightSnowWithThunder = "Patchy light snow with thunder"
	case moderateOrHeavySnowWithThunder = "Moderate or heavy snow with thunder"
	
	var sfSymbol: String {
		switch self {
		case .sunny, .clear:
			return "sun.max"
		case .partlyCloudy:
			return "cloud.sun"
		case .cloudy, .overcast:
			return "cloud"
		case .mist, .fog, .freezingFog:
			return "cloud.fog"
		case .patchyRainPossible:
			return "cloud.drizzle"
		case .patchySleetPossible, .lightSleet, .moderateOrHeavySleet, .moderateOrHeavySleetShower:
			return "cloud.sleet"
		case .lightSnow, .blowingSnow, .patchySnowPossible:
			return "cloud.snow"
		case .moderateOrHeavySnowShowers:
			return "cloud.snow.fill"
		case .thunderyOutbreaksPossible:
			return "cloud.bolt"
		case .blizzard:
			return "wind.snow"
		case .patchyLightdrizzle, .drizzle, .freezingDrizzle, .heavyFreezingDrizzle:
			return "cloud.drizzle"
		case .patchyLightRain, .lightRain, .moderateRain, .moderateRainTimes:
			return "cloud.rain"
		case .heavyRain, .heavyRainTimes, .moderateOrHeavyFreezingRain:
			return "cloud.heavyrain"
		case .lightRainShower, .moderateOrHeavyRainShower, .torrentialRainShower:
			return "cloud.rain"
		case .patchyLightRainWithThunder, .moderateOrHeavyRainWithThunder:
			return "cloud.bolt.rain"
		case .patchyLightSnow, .moderateSnow, .icePellets, .lightShowersOfIcePellets, .moderateHeavyShowersIcePellets:
			return "cloud.snow"
		case .patchyHeavySnow, .heavySnow:
			return "snowflake"
		case .patchyLightSnowWithThunder, .moderateOrHeavySnowWithThunder:
			return "cloud.hail"
		}
	}
	
	var backgroundGradient: LinearGradient {
		switch self {
		case .sunny:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color.yellow, Color.blue]),
				startPoint: .top,
				endPoint: .bottom)
		case .clear:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color.blue, Color.white]),
				startPoint: .top,
				endPoint: .bottom)
		case .cloudy, .partlyCloudy:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color(hex: "#548FAB"), Color(hex: "#C0C6CB")]),
				startPoint: .top,
				endPoint: .bottom)
		case .overcast:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color.gray, Color.gray, Color.white]),
				startPoint: .top,
				endPoint: .bottom)
		case .fog, .freezingFog, .mist:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color(hex: "#EFB6C8"), Color(hex: "#A888B5"), Color(hex: "#8174A0")]),
				startPoint: .top,
				endPoint: .bottom)
		case .patchyRainPossible, .heavyRain, .lightRain, .patchyLightRain, .moderateRain, .moderateRainTimes, .heavyRainTimes, .lightRainShower, .moderateOrHeavyFreezingRain, .moderateOrHeavyRainShower:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color(hex: "#515F7A"), Color(hex: "#8290AC"), Color(hex: "#BCC7CC"), Color(hex: "#D5D9E0"), Color(hex: "#8C96A1")]),
				startPoint: .top,
				endPoint: .bottom)
		case .torrentialRainShower:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color.black, Color.white, Color.orange]),
				startPoint: .top,
				endPoint: .bottom)
		case .patchyLightRainWithThunder, .moderateOrHeavyRainWithThunder, .thunderyOutbreaksPossible:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color.black, Color.white]),
				startPoint: .top,
				endPoint: .bottom)
		case .lightSnow, .heavySnow, .blowingSnow, .moderateSnow, .patchyHeavySnow, .patchyLightSnow, .patchySnowPossible, .moderateOrHeavySnowShowers, .lightSleet, .patchySleetPossible, .moderateOrHeavySleet, .moderateOrHeavySleetShower, .blizzard, .patchyLightSnowWithThunder, .moderateOrHeavySnowWithThunder:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color(hex: "#A9A9A9"), .gray, Color(hex: "#D3D3D3")]),
				startPoint: .top,
				endPoint: .bottom)
		case .drizzle, .freezingDrizzle, .heavyFreezingDrizzle, .patchyLightdrizzle:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color.white, Color.gray]),
				startPoint: .top,
				endPoint: .bottom)
		case .icePellets, .lightShowersOfIcePellets, .moderateHeavyShowersIcePellets:
			return LinearGradient(
				gradient: Gradient(
					colors: [Color(hex: "#32407B"), Color.white, Color.gray]),
				startPoint: .top,
				endPoint: .bottom)
		}
	}
}

