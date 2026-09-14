//
//  OnBoardingViewModel.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation
import SwiftData

@Observable
class OnBoardingViewModel {
    var allColors: [ColorSwatch] = []
    var allFonts: [FontPairing] = []
    
    var selectedTargetUser: TargetUser?
    var selectedIndustry: Industry?
    var selectedPersonality: Personality?
    
    init() {
        self.allColors = DesignSystemLoader.load([ColorSwatch].self, filename: "colors") ?? []
        self.allFonts = DesignSystemLoader.load([FontPairing].self, filename: "fonts") ?? []
    }
}
