//
//  Launch.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

extension Launch {
    static let preview: Launch = {
            let sampleLinks = Links(
                patch: Patch(
                    small: URL(string: "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png"),
                    large: URL(string: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png")
                ),
            )

            return Launch(
                id: "62dd70d5202306255024d139",
                name: "Crew-5",
                details: "SpaceX Crew-5 mission to the ISS with 4 astronauts.",
                rocket: "Falcon 9",
                success: true,
                dateUTC: Date(),
                capsules: ["617c05591bad2c661a6e2909"],
                payloads: ["62dd73ed202306255024d145"],
                crew: [
                    Crew(crew: "62dd7196202306255024d13c", role: "Commander"),
                    Crew(crew: "62dd71c9202306255024d13d", role: "Pilot")
                ],
                launchPad: "5e9e4502f509094188566f88",
                links: sampleLinks
            )
        }()
}
