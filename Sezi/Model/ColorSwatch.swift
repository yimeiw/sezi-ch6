//
//  ColorSwatch.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation

struct ColorSwatch: Codable, Identifiable, Hashable {
    var id: String {
        hex
    }
    
    let name: String
    let hex: String
    let hue, saturation, lightness: Double
    let targetUsers: [String]
    let industry: [String]
    let tags: [String]
    let recommendedTextColor: String
    let contrastRatio: Double
    let wcagAANormal, wcagAAANormal: Bool
    let personalityCategory: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, hex, hue, saturation, lightness, tags, industry
        case targetUsers = "target_users"
        case recommendedTextColor = "recommended_text_color"
        case contrastRatio = "contrast_ratio"
        case wcagAANormal = "wcag_aa_normal"
        case wcagAAANormal = "wcag_aaa_normal"
        case personalityCategory = "personality_category"
    }
}
