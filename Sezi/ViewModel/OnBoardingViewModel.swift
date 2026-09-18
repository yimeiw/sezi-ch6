//
//  OnBoardingViewModel.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI
import Foundation
import SwiftData

@Observable
class OnBoardingViewModel {
    var allColors: [ColorSwatch] = []
    var allFonts: [FontPairing] = []
    
    var selectedTargetUser: TargetUser?
    var selectedIndustry: Industry?
    var selectedPersonalities: [Personality] = []
    
    var scoringWeights = ScoringWeights()
    var generatedPalette: ColorPalette?
    var generatedFontPairing: FontPairing?
    
    var path = NavigationPath()
    
    private let maxPersonalityCategory = 3
    
    init() {
        self.allColors = DesignSystemLoader.load([ColorSwatch].self, filename: "colors") ?? []
        self.allFonts = DesignSystemLoader.load([FontPairing].self, filename: "fonts") ?? []
    }
    
    func toggleTarget(_ target: TargetUser) {
        if selectedTargetUser?.id == target.id {
            selectedTargetUser = nil
        } else {
            selectedTargetUser = target
        }
    }
    
    func toggleIndustry(_ industry: Industry) {
        if selectedIndustry?.id == industry.id {
            selectedIndustry = nil
        } else {
            selectedIndustry = industry
        }
    }
    
    func togglePersonality(_ personality: Personality) {
        if let index = selectedPersonalities.firstIndex(where: { $0.id == personality.id }) {
            selectedPersonalities.remove(at: index)
        } else if selectedPersonalities.count < maxPersonalityCategory {
            selectedPersonalities.append(personality)
        }
    }
    
    func generateResults() {
        generatedPalette = PaletteGenerator.generate(colors: allColors, target: selectedTargetUser, industry: selectedIndustry, personalities: selectedPersonalities, weights: scoringWeights)
        
        generatedFontPairing = FontSelector.select(fonts: allFonts, target: selectedTargetUser, industry: selectedIndustry, personalities: selectedPersonalities, weights: scoringWeights)
    }
    
    func resetToStart() {
        selectedTargetUser = nil
        selectedIndustry = nil
        selectedPersonalities = []
        generatedPalette = nil
        generatedFontPairing = nil
        path = NavigationPath()
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
