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
        Personality(displayName: "Playful & Fun", image: "playful", key: "playful_fun"),
        Personality(displayName: "Bold & Energetic", image: "bold", key: "bold_energetic"),
        Personality(displayName: "Calm & Serene", image: "calm", key: "calm_serene"),
        
        Personality(displayName: "Elegant & Sophisticated", image: "elegant", key: "elegant_sophisticated"),
        Personality(displayName: "Trustworthy & Reliable", image: "trust", key: "trustworthy_reliable"),
        Personality(displayName: "Mysterious & Dramatic", image: "mysterious", key: "mysterious_dramatic"),
        
        Personality(displayName: "Adventurous & Daring", image: "adventure", key: "adventurous_daring"),
        Personality(displayName: "Warm & Friendly", image: "warm", key: "warm_friendly"),
        Personality(displayName: "Modern & Innovative", image: "modern", key: "modern_innovative"),
        
        Personality(displayName: "Natural & Earthy", image: "natural", key: "natural_earthy")
    ]
}
