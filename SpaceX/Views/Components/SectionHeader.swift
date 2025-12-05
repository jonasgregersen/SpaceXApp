//
//  SectionHeader.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

/// Dette ViewComponent bliver brugt til tydelig section fordeling i launchDetailView.
struct SectionHeader: View {
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
