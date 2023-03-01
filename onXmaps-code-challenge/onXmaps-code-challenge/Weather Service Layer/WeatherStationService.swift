//
//  WeatherStationService.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation
import Combine

protocol WeatherStationServiceType {
    func fetchTodayWeatherData() -> AnyPublisher<[WeatherStation], Error>
    func fetchTomorrowWeatherData() -> AnyPublisher<[WeatherStation], Error>
}

struct WeatherStationService: WeatherStationServiceType {
    private let network: NetworkManagerType
    
    init(network: NetworkManagerType = NetworkManager()) {
        self.network = network
    }
    
    func fetchTodayWeatherData() -> AnyPublisher<[WeatherStation], Error> {
        network
            .fetchData(at: .todayEndpoint)
            .decode(type: [WeatherStation].self, decoder: WeatherStationAPI.jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func fetchTomorrowWeatherData() -> AnyPublisher<[WeatherStation], Error> {
        network
            .fetchData(at: .tomorrowEndpoint)
            .decode(type: [WeatherStation].self, decoder: WeatherStationAPI.jsonDecoder)
            .eraseToAnyPublisher()
    }
}

private extension URL {
    static var todayEndpoint: URL {
        URL(string: WeatherStationAPI.root + "/4ff0a1510551295be0ec0369186d83ed/raw/fc7b5308546c0e1085d8748134138cef4281ac11/today.json")!
    }
    
    static var tomorrowEndpoint: URL {
        URL(string: WeatherStationAPI.root + "/6421fa7f0f3789801935d6d37df55922/raw/e673021836819aa20018853643c8769fd4d129fd/tomorrow.json")!
    }
}
