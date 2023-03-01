//
//  WeatherStationAPI.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation

struct WeatherStationAPI {
    static let root: String = "https://gist.githubusercontent.com/rcedwards"
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
}
