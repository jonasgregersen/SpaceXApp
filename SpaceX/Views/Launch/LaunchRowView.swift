//
//  LaunchRow.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct LaunchRowView: View {
    var launch: Launch
    var body: some View {
        HStack {
            AsyncImage(url: launch.patchImage, transaction: Transaction(animation: .easeIn)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .transition(.opacity.animation(.easeIn(duration: 0.3)))

                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.gray)

                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading) {
                Text(launch.name)
                    .bold()
                Text(DateFormatter.uiDate.string(from: launch.dateUTC))
                    .font(.caption)
                if let success = launch.success {
                    Text(success ? "Succeeded" : "Failed")
                        .font(.caption)
                } else {
                    Text("Unknown")
                        .font(.caption)
                }
            }
            Spacer()
        }
    }
}


#Preview {
    LaunchRowView(launch: Launch.preview)
        .scaledToFit()
}
