//
//  SectionHeader.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct SectionHeader: View { // Section header bliver brugt til tydelig section fordeling i launchDetailView.
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .textCase(.uppercase)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    SectionHeader(title: "Test")
}
