//
//  AnyPad.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 05/12/2025.
//

import Foundation

struct AnyPad: Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(_ pad: PadProtocol) {
        self.id = pad.id
        self.name = pad.name
        self.latitude = pad.latitude
        self.longitude = pad.longitude
    }
}
