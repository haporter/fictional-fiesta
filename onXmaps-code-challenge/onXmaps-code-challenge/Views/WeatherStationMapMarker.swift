//
//  WeatherStationMapMarker.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation
import MapKit

class WeatherStationMapMarker: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let weatherStation = annotation as? WeatherStation else { return }
            
            canShowCallout = true
            subtitleVisibility = .visible
            detailCalloutAccessoryView  = WeatherStationCallout(weatherStation: weatherStation)
        }
    }
}
