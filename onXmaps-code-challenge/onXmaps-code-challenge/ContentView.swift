//
//  ContentView.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WeatherStationMap()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
