//
//  OXMapView.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import SwiftUI
import MapKit

struct OXMapView: UIViewRepresentable {
    
    @ObservedObject var viewModel: MapViewModel = .init()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.region = viewModel.region
        mapView.delegate = context.coordinator
        mapView.register(WeatherStationMapMarker.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        viewModel.fetchWeatherData()
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let oldAnnotations = uiView.annotations.compactMap { $0 as? WeatherStation }
        if Set(oldAnnotations) == Set(viewModel.weatherStations) {
            uiView.removeAnnotations(oldAnnotations)
            uiView.addAnnotations(viewModel.weatherStations)
        } else {
            let subtractions = Set(oldAnnotations).subtracting(Set(viewModel.weatherStations))
            let insertions = Set(viewModel.weatherStations).subtracting(Set(oldAnnotations))
            uiView.removeAnnotations(subtractions.array)
            uiView.addAnnotations(insertions.array)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension OXMapView {
    final class Coordinator: NSObject, MKMapViewDelegate {
        let mapView: OXMapView
        
        init(_ mapView: OXMapView) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            self.mapView.viewModel.mapRegionSubject.send(mapView.region)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let weatherStation = annotation as? WeatherStation, let markerView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? WeatherStationMapMarker {
                markerView.annotation = weatherStation
                
                return markerView
            }
            
            return nil
        }
    }
}
