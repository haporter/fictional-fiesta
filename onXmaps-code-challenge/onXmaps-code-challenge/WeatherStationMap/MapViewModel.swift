//
//  MapViewModel.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    let weatherService: WeatherStationServiceType
    
    @Published private(set) var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.924, longitude: -108.0955), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 20))
    @Published private(set) var weatherStations: [WeatherStation] = []
    @Published var daySelection: Int = 0
    @Published var weatherDisplayData: Int
    @Published var shouldRefresh: Bool = false
    var mapRegionSubject = PassthroughSubject<MKCoordinateRegion, Never>()
        
    private var todayWeatherData = CurrentValueSubject<[WeatherStation], Never>([])
    private var tomorrowWeatherData = CurrentValueSubject<[WeatherStation], Never>([])
    private var bag = Set<AnyCancellable>()
    
    init(weatherService: WeatherStationServiceType = WeatherStationService()) {
        self.weatherService = weatherService
        self.weatherDisplayData = UserDefaultsStore.stationDataToDisplay
        subscribe()
    }
    
    private func subscribe() {
        Publishers
            .CombineLatest3(todayWeatherData, tomorrowWeatherData, $daySelection)
//            .combineLatest($daySelection)
            .map { (today, tomorrow, daySelection) in
                daySelection == 0 ? today : tomorrow
            }
            .assign(to: &$weatherStations)
        
        mapRegionSubject
            .combineLatest($daySelection, todayWeatherData, tomorrowWeatherData)
            .map { (region, selection, todayData, tomorrowData) in
                let weatherData = selection == 0 ? todayData : tomorrowData
                
                return (region, weatherData)
            }
            .map(filter)
            .receive(on: RunLoop.main)
            .assign(to: &$weatherStations)
        
        $daySelection
            .combineLatest(todayWeatherData, tomorrowWeatherData)
            .map { (selection, todayData, tomorrowData) in
                selection == 0 ? todayData : tomorrowData
            }
            .assign(to: &$weatherStations)
        
        $weatherDisplayData
            .dropFirst()
            .sink { [weak self] value in
                UserDefaultsStore.stationDataToDisplay = value
                self?.shouldRefresh = true
            }
            .store(in: &bag)
    }
    
    private func filter(by span: MKCoordinateRegion, for markers: [WeatherStation]) -> [WeatherStation] {
        markers.filter { span.contains(coordinate: $0.coordinate) }
    }
    
    private func fetchTodayWeather() -> some Publisher<[WeatherStation], Never> {
        weatherService
            .fetchTodayWeatherData()
            .catch { _ in
                //TODO: - Handle error
                Empty()
            }
    }
    
    private func fetchTomorrowWeather() -> some Publisher<[WeatherStation], Never> {
        weatherService
            .fetchTomorrowWeatherData()
            .catch { _ in
                //TODO: - Handle error
                Empty()
            }
    }
    
    func fetchWeatherData() {
        fetchTodayWeather()
            .receive(on: RunLoop.main)
            .subscribe(todayWeatherData)
            .store(in: &bag)
        
        fetchTomorrowWeather()
            .receive(on: RunLoop.main)
            .subscribe(tomorrowWeatherData)
            .store(in: &bag)
    }
}
