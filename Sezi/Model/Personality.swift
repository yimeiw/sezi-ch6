//
//  Personality.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation

struct Personality {
    let id: UUID = UUID()
    let displayName: String
    let image: String
    let key : String
}

extension Personality {
    static let allPersonality: [Personality] = [
        Personality(displayName: "Tech/Saas", image: "tech", key: "tech_startup"),
        Personality(displayName: "Finance/Fintech", image: "finance", key: "finance_professional"),
        Personality(displayName: "Health/Wellness", image: "health", key: "health_wellness"),
    ]
}
