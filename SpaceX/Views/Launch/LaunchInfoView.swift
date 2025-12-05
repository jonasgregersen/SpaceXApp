//
//  LaunchInfoView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

// Dette View håndterer visning af basale oplysninger for et launch, samt visning af patch.
struct LaunchInfoView: View {
    var launch: Launch
    var body: some View {
        VStack {
            AsyncImage(url: launch.patchImage) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
            }
            VStack {
                Text(launch.name)
                    .font(.headline)
                Text(DateFormatter.uiDate.string(from: launch.dateUTC))
                if let success = launch.success {
                    Text(success ? "Succeeded" : "Failed")
                        .foregroundColor(success ? .green : .red)
                        .padding() // Hvis launch er succesfuld, er teksten grøn, ellers rød.
                } else {
                    Text("Status Not Available")
                        .foregroundColor(.gray)
                        .padding() // Hvis der ikke er fundet en status, er teksten grå.
                }
                if let details = launch.details {
                    Text(details)
                }
            }
        }
    }
}

#Preview {
    LaunchInfoView(launch: Launch.preview)
        .scaledToFit()
}


