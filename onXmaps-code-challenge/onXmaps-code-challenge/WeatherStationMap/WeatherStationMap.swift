//
//  WeatherStationMap.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import SwiftUI

struct WeatherStationMap: View {
    @StateObject var viewModel: MapViewModel = .init()
    
    var body: some View {
        OXMapView(viewModel: viewModel)
            .overlay(alignment: .bottom) {
                HStack(spacing: 16) {
                    Picker("Weather report", selection: $viewModel.daySelection) {
                        Text("Today")
                            .tag(0)
                            .foregroundColor(.yellow)
                        Text("Tomorrow")
                            .tag(1)
                            .foregroundColor(.yellow)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Display weather data", selection: $viewModel.weatherDisplayData) {
                        Image(systemName: "thermometer.medium")
                            .tag(0)
                        Image(systemName: "wind")
                            .tag(1)
                        Image(systemName: "cloud.rain")
                            .tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 40, trailing: 24))
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.8))
            }
    }
}

struct WeatherStationMap_Previews: PreviewProvider {
    static var previews: some View {
        WeatherStationMap()
    }
}
