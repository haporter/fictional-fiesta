//
//  MKCoordinateRegion+Extension.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import MapKit

extension MKCoordinateRegion {
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        cos((center.latitude - coordinate.latitude) * .pi/180) > cos(span.latitudeDelta / 2.0 * .pi / 180) &&
        cos((center.longitude - coordinate.longitude) * .pi/180) > cos(span.longitudeDelta / 2.0 * .pi / 180)
    }
}
