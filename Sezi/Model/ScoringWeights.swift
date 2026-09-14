//
//  ScoringWeights.swift
//  Sezi
//
//  Created by Yimei Winata on 14/09/26.
//

import Foundation

struct ScoringWeights{
    var targetUser: Double = 3.0
    var industry: Double = 2.0
    var personality: Double = 3.0
}

enum ScoringEngine {
    static func score(color: ColorSwatch, target: TargetUser?, industry: Industry?, personality: Personality?, weights: ScoringWeights) -> Double {
        var score = 0.0
        
        if let target, color.targetUsers.contains(target.key) {
            score += weights.targetUser
        }
        
        if let industry, color.industry.contains(industry.key) {
            score += weights.industry
        }
        
        if let personality, color.personalityCategory.contains(personality.key) {
            score += weights.personality
        }
        return score
    }
}
