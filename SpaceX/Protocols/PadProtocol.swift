//
//  PadProtocol.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 05/12/2025.
//

import Foundation

protocol PadProtocol: Identifiable{
    var id: String {get}
    var name: String {get}
    var latitude: Double {get}
    var longitude: Double {get}
}
