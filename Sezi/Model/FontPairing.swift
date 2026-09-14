//
//  FontPairing.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation

struct FontPairing: Codable, Identifiable, Hashable {
    var id: String {
        name
    }
    let name: String
    let headingFont: String
    let bodyFont: String
    let style: String
    let targetUsers: [String]
    let industry: [String]
    let tags: [String]
    let source: String
    let personalityCategory: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, style, tags, source, industry
        case headingFont = "heading_font"
        case bodyFont = "body_font"
        case targetUsers = "target_users"
        case personalityCategory = "personality_category"
    }
}
