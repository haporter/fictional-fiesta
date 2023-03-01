//
//  WeatherStation.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation
import MapKit

final class WeatherStation: NSObject, Codable {
    let id: String
    let name: String
    let longitude: Double
    let latitude: Double
    let temperature: Double?
    let windSpeed: Double?
    let windDirection: Int?
    let chanceOfPrecipitation: Int

}

extension WeatherStation: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? { name }
    
    var subtitle: String? {
        var value: String?
        switch UserDefaultsStore.stationDataToDisplay {
        case 0:
            if let temperature {
                value = "\(Measurement<UnitTemperature>(value: temperature.rounded(), unit: .fahrenheit))"
            }
        case 1:
            if let windSpeed {
                value = "\(Measurement(value: windSpeed, unit: UnitSpeed.milesPerHour))"
            }
        case 2:
            value = "\(chanceOfPrecipitation.formatted(.percent))"
        default:
            break
        }
        return value
    }
}
