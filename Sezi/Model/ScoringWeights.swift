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

protocol DesignAsset {
    var targetUsers: [String] { get }
    var industry: [String] { get }
    var personalityCategory: [String] { get }
}

extension ColorSwatch: DesignAsset{}
extension FontPairing: DesignAsset{}

enum ScoringEngine {
    static func score(asset:DesignAsset, target: TargetUser?, industry: Industry?, personalities: [Personality], weights: ScoringWeights) -> Double {
        var score = 0.0
        
        if let target, asset.targetUsers.contains(target.key) {
            score += weights.targetUser
        }
        
        if let industry, asset.industry.contains(industry.key) {
            score += weights.industry
        }
        
        let personalityMatches = personalities.filter { asset.personalityCategory.contains($0.key) }.count
        
        score += weights.personality * Double(personalityMatches)
        return score
    }
    
    static func score(color: ColorSwatch, target: TargetUser?, industry: Industry?, personalities: [Personality], weights: ScoringWeights) -> Double {
        score(asset: color, target: target, industry: industry, personalities: personalities, weights: weights)
    }
    
    static func score(font: FontPairing, target: TargetUser?, industry: Industry?, personalities: [Personality], weights: ScoringWeights) -> Double {
        score(asset: font, target: target, industry: industry, personalities: personalities, weights: weights)
    }
}
