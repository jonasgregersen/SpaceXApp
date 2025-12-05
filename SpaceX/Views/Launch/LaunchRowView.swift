//
//  LaunchRow.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

/// View der viser en launch i en liste med billede, navn, dato, successtatus og favoritmarkering.
/// Bruges primært i LaunchListView.
struct LaunchRowView: View {
    var launch: Launch
    @EnvironmentObject private var userFavVM: UserFavoritesViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    var body: some View {
        HStack {
            // Loader patch-billedet asynkront med animation, fallback til placeholder ved fejl.
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
                HStack {
                    Text(launch.name)
                        .bold()
                }
                Text(DateFormatter.uiDate.string(from: launch.dateUTC)) // Datoen formatteres med en custom                                                         DateFormatter.
                    .font(.caption)
                if let success = launch.success {
                    if success {
                        Text("Succeeded")
                            .font(.caption)
                            .foregroundColor(.green)
                    } else {
                        Text("Failed")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                } else {
                    Text("Unknown")
                        .font(.caption)
                }
                
            }
            Spacer()
            // Vis favoritikon hvis launch er markeret som favorit og brugeren er logget ind.
            if authVM.isLoggedIn {
                if userFavVM.isFavorite(launch.id) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}


#Preview {
    LaunchRowView(launch: Launch.preview)
        .scaledToFit()
}
