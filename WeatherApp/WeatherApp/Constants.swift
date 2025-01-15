//
//  Constants.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/13/25.
//

import Foundation
import SwiftUI

enum Gradients {
	static let cloudy = LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

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
}

