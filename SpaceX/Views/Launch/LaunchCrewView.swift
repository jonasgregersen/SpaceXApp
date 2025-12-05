//
//  CrewView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

// Dette View håndterer visning af crew informationer som crew medlemmer i LaunchDetailView.
struct LaunchCrewView: View {
    var crew: [Crew]
    @EnvironmentObject private var vm: CrewViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !vm.crewMembers.isEmpty { // Vis kun hvis der er crew members.
                LazyVStack(spacing: 10) {
                    ForEach(vm.crewMembers, id: \.0.id) { member, role in
                        HStack(spacing: 12) {
                            AsyncImage(url: member.image) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(member.name)
                                    .font(.subheadline)
                                Text(role)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.secondarySystemBackground))
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
        .task {
            await vm.load(crew)
        }
    }
}


#Preview {
    LaunchCrewView(crew: [Crew.preview])
}
