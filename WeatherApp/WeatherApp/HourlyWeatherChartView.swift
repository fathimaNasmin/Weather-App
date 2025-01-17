//
//  HourlyWeatherChartView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/15/25.
//

import SwiftUI
import Charts


struct HourlyData: Identifiable {
	let temp: Double
	let time: Int
	var id: Int {
		time
	}
}

struct HourlyWeatherChartView: View {
	
	let sampleData: [HourlyData] = [
		HourlyData(temp: 16.0, time: 5),
		HourlyData(temp: 18.0, time: 6),
		HourlyData(temp: 22.0, time: 7),
		HourlyData(temp: 23.0, time: 8),
		HourlyData(temp: 20.0, time: 9),
		HourlyData(temp: 19.0, time: 10),
		HourlyData(temp: 18.0, time: 11),
		HourlyData(temp: 34.0, time: 12),
		HourlyData(temp: 32.0, time: 13),
		HourlyData(temp: 20.0, time: 14)
	]
	
	var body: some View {
			VStack {
				Chart {
					ForEach(sampleData, id: \.time) { temperature in
						LineMark(
							x: .value("Time", temperature.time),
							y: .value("Temperature", temperature.temp)
						)
						.lineStyle(.init(lineWidth: 1, dash: [3, 2]))
						.foregroundStyle(Color.white.opacity(0.2))
						.interpolationMethod(.cardinal)

						// RuleMark: To show grid line to temperature
						RuleMark(x: .value("time", temperature.time) ,
								 yStart: .value("start", 0) ,
								 yEnd: .value("end", temperature.temp)
						)
						.lineStyle(.init(lineWidth: 1, dash: [3, 2]))
						.foregroundStyle(Color.white.opacity(0.2))
						
						
						// PointMark: Add Annotations for each temperature point
						PointMark(
							x: .value("Time", temperature.time),
							y: .value("Temperature", temperature.temp)
						)
						.symbol {
							Circle()
								.frame(width: 4, height: 4)
								.foregroundStyle(Color.white)
						}
						.annotation(position: .top, alignment: .center) {
							Text("\(temperature.temp, specifier: "%.0f")°")
								.font(.custom(Fonts.RobotoCondensedSemiBold, size: 14))
								.foregroundColor(.white)
								.padding(.bottom, 2)
						}
						
					}
				}
				.chartScrollableAxes(.horizontal)
				.chartXVisibleDomain(length: 8)
				.chartXScale(domain: sampleData.first!.time...sampleData.last!.time)
				.chartXAxis {
					AxisMarks(values: .automatic(desiredCount: sampleData.count)){
						AxisValueLabel()
							.foregroundStyle(Color.white)
					}
				}
				.chartYAxis(.hidden)
				.frame(height: 100)
				.foregroundStyle(.white.opacity(0.8))
				.padding()
				.padding(.leading, 15)
				
			}
	}
	
}

#Preview {
    HourlyWeatherChartView()
}
