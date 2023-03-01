//
//  Int+Extension.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation

extension Int {
    func rad2deg() -> CGFloat {
        let cgFloat = CGFloat(self)
        return CGFloat(cgFloat * 180 / .pi)
    }
    
    func deg2rad() -> CGFloat {
        let cgFloat = CGFloat(self)
        return CGFloat(cgFloat * .pi / 180)
    }
}
