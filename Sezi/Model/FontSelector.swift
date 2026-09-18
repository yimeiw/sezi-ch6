//
//  FontSelector.swift
//  Sezi
//
//  Created by Yimei Winata on 15/09/26.
//

import Foundation

enum FontSelector {
    static func select(fonts: [FontPairing], target: TargetUser?, industry: Industry?, personalities: [Personality], weights: ScoringWeights) -> FontPairing? {
        fonts.map { (pairing: $0, score: ScoringEngine.score(font: $0, target: target, industry: industry, personalities: personalities, weights: weights)) }
            .sorted { $0.score > $1.score }
            .first?.pairing
    }
}
