//
//  UserDefaultsStore.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation

struct UserDefaultsStore {
    @UserDefaultValue(key: "stationDataToDisplay", defaultValue: 0)
    static var stationDataToDisplay: Int
}
