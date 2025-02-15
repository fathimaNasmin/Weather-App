//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/14/25.
//

import Foundation


struct WeatherModel: Decodable {
	let location: Location
	let current: Current
	let forecast: Forecast
	
	struct Location: Decodable {
		let name: String
		let currentDateEpoch: Date
		let timeZoneId: String
		
		
		enum CodingKeys: String, CodingKey {
			case name
			case currentDateEpoch = "localtime_epoch"
			case timeZoneId = "tz_id"
		}
		
		var now: String {
			let formatter = DateFormatter()
			formatter.dateFormat = "E, h:mm a"
			
			if let timezone = TimeZone(identifier: timeZoneId) {
				formatter.timeZone = timezone
			}

			return formatter.string(from: currentDateEpoch)
		}
	}
	
	
	struct Current: Decodable {
		let tempC: Double
		let tempF: Double
		let condition: Condition
		let windKph: Double
		let pressureIn: Double
		let rainInMm: Double
		let humidity: Int
		let feelslikeC: Double
		let feelslikeF: Double
		let dewpointC: Double
		let visibility: Double
		
		struct Condition: Decodable {
			let text: String
		}
		
		// CodingKeys to handle JSON key that differ from property names
		enum CodingKeys: String, CodingKey {
			case tempC = "temp_c"
			case tempF = "temp_f"
			case condition
			case windKph = "wind_kph"
			case pressureIn = "pressure_in"
			case rainInMm = "precip_mm"
			case humidity
			case feelslikeC = "feelslike_c"
			case feelslikeF = "feelslike_f"
			case dewpointC = "dewpoint_c"
			case visibility = "vis_km"
		}
		
		var formatTempC: String { tempC.rounded(to: 0) }
		
		var formatTempF: String { tempF.rounded(to: 0) }
	}
	
	
	struct Forecast: Decodable {
		let forecastDay: [SevenForecastDay]
		
		enum CodingKeys: String, CodingKey {
			case forecastDay = "forecastday"
		}
		
		struct SevenForecastDay: Decodable, Hashable, Equatable {
			let date: String
			let dateEpoch: Date
			let day: SingleDay
			let hourly: [HourForecast]
			
			var formattedDateEpoch: String {
				let formatter = DateFormatter()
				formatter.dateFormat = "E"
				
				return formatter.string(from: dateEpoch)
			}
			
			enum CodingKeys: String, CodingKey {
				case date
				case dateEpoch = "date_epoch"
				case day
				case hourly = "hour"
			}
			
			struct SingleDay: Decodable, Hashable, Equatable {
				let maxTempC: Double
				let maxTempF: Double
				let minTempC: Double
				let minTempF: Double
				let condition: TodayCondition
				let dailyChanceOfRain: Int
				
				var formattedMaxTempC: String { maxTempC.rounded(to: 0) }
				
				var formattedMaxTempF: String { maxTempF.rounded(to: 0) }
				
				var formattedMinTempC: String { minTempC.rounded(to: 0) }
				
				var formattedMinTempF: String { minTempF.rounded(to: 0) }
				
				enum CodingKeys: String, CodingKey {
					case maxTempC = "maxtemp_c"
					case maxTempF = "maxtemp_f"
					case minTempC = "mintemp_c"
					case minTempF = "mintemp_f"
					case condition
					case dailyChanceOfRain = "daily_chance_of_rain"
				}
				
				struct TodayCondition: Decodable, Hashable, Equatable {
					let text: String
					
					var trimmedText: String {
						return text.trimmingCharacters(in: .whitespacesAndNewlines)
					}
					
					enum CodingKeys: String, CodingKey {
						case text
					}
				}
				
			}
		}
	}
}

struct HourForecast: Decodable, Hashable, Equatable {
	let timeEpoch: Int
	let time: String
	let tempC: Double
	let tempF: Double
	let chanceOfRain: Int
	
	var formattedTempC: String { tempC.rounded(to: 0)}
	
	var formattedTempF: String { tempF.rounded(to: 0) }
	
	
	var date: Date {
		Date(timeIntervalSince1970: TimeInterval(timeEpoch))
	}
	
	var hour: Int {
		let calender = Calendar.current
		return calender.component(.hour, from: date)
	}
	
	enum CodingKeys: String, CodingKey {
		case timeEpoch = "time_epoch"
		case time
		case tempC = "temp_c"
		case tempF = "temp_f"
		case chanceOfRain = "chance_of_rain"
	}
}
