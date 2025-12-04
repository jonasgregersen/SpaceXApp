//
//  CapsuleRowView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct CapsuleRowView: View {
    var capsule: Capsule
    var body: some View {
        VStack {
            Text(capsule.serial)
                .bold()
            Text(capsule.type)
                .font(.caption)
            Text(capsule.status)
                .font(.caption)
        }
    }
}


