//
//  HourlyWeatherChartView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/15/25.
//

import SwiftUI
import Charts

func hourInString(date: Date) -> String {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "h a"
	
	return dateFormatter.string(from: date)
}


struct HourlyWeatherChartView: View {
	let hourlyData: [HourForecast]
	
	var minTempC: Double? {
		hourlyData.min(by: { $0.tempC < $1.tempC })?.tempC
	}

	var body: some View {
			VStack {
				if hourlyData.isEmpty {
					Text("No data available")
				} else {
					Chart {
						ForEach(hourlyData, id: \.time) { temperature in
							LineMark(
								x: .value("Time", temperature.date),
								y: .value("Temperature", temperature.tempC)
							)
							.lineStyle(.init(lineWidth: 1, dash: [3, 2]))
							.foregroundStyle(Color.white.opacity(0.2))
							.interpolationMethod(.cardinal)
							
							// RuleMark: To show grid line to temperature
							RuleMark(x: .value("time", temperature.date) ,
									 yStart: .value("start", minTempC ?? 0) ,
									 yEnd: .value("end", temperature.tempC)
							)
							.lineStyle(.init(lineWidth: 1, dash: [3, 2]))
							.foregroundStyle(Color.white.opacity(0.2))
							
							
							// PointMark: Add Annotations for each temperature point
							PointMark(
								x: .value("Time", temperature.date),
								y: .value("Temperature", temperature.tempC)
							)
							.symbol {
								Circle()
									.frame(width: 4, height: 4)
									.foregroundStyle(Color.white)
							}
							.annotation(position: .top, alignment: .center) {
								Text("\(temperature.tempC, specifier: "%.0f")°")
									.font(.custom(Fonts.RobotoCondensedSemiBold, size: 14))
									.foregroundColor(.white)
									.padding(.bottom, 2)
							}
							
						}
					}
					.frame(height: 100)
					.chartXScale(domain: hourlyData.first!.date...hourlyData.last!.date)
					.chartXAxis(content: {
						AxisMarks(values: hourlyData.map({$0.date})) { value in
							if let date = value.as(Date.self){
								AxisValueLabel(centered: true) {
									Text(hourInString(date: date))
										.foregroundStyle(.white)
								}
							}
						}
					})
					.chartYAxis(.hidden)
					.chartScrollableAxes(.horizontal)
					.foregroundStyle(.white.opacity(0.8))
					.padding()
				}
			}
	}
	
}

//#Preview {
//    HourlyWeatherChartView()
//}
