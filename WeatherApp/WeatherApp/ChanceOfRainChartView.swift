//
//  ChanceOfRainChartView.swift
//  WeatherApp
//
//  Created by Fathima Nasmin on 1/18/25.
//

import SwiftUI
import Charts

struct ChanceOfRainChartView: View {
	let hourlyRainData: [HourForecast]
	
	var body: some View {
		VStack {
			if hourlyRainData.isEmpty {
				Text("No data available")
			} else {
				Chart {
					ForEach(hourlyRainData, id: \.time) { temperature in
						LineMark(
							x: .value("Time", temperature.date),
							y: .value("Temperature", temperature.chanceOfRain)
						)
						.lineStyle(.init(lineWidth: 1, dash: [3, 2]))
						.foregroundStyle(Color.white.opacity(0.2))
						.interpolationMethod(.cardinal)
						
						// RuleMark: To show grid line to temperature
						RuleMark(x: .value("time", temperature.date) ,
								 yStart: .value("start", 0) ,
								 yEnd: .value("end", temperature.chanceOfRain)
						)
						.lineStyle(.init(lineWidth: 1, dash: [3, 2]))
						.foregroundStyle(Color.white.opacity(0.2))
						
						
						// PointMark: Add Annotations for each temperature point
						PointMark(
							x: .value("Time", temperature.date),
							y: .value("Temperature", temperature.chanceOfRain)
						)
						.symbol {
							Circle()
								.frame(width: 4, height: 4)
								.foregroundStyle(Color.white)
						}
						.annotation(position: .top, alignment: .center) {
							Text(temperature.chanceOfRain > 0 ? "\(temperature.chanceOfRain)%" : "")
								.font(.custom(Fonts.RobotoCondensedSemiBold, size: 14))
								.foregroundColor(.white)
								.padding(.bottom, 2)
						}
						
					}
				}
				.frame(height: 100)
				.chartXScale(domain: hourlyRainData.first!.date...hourlyRainData.last!.date)
				.chartXAxis(content: {
					AxisMarks(values: hourlyRainData.map({$0.date})) { value in
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
//    ChanceOfRainChartView()
//}
