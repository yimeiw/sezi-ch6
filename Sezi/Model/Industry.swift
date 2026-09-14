//
//  Industry.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation

struct Industry {
    let id: UUID = UUID()
    let displayName: String
    let image: String
    let key: String
}

extension Industry {
    static let allIndustry: [Industry] = [
        Industry(displayName: "Tech/Saas", image: "tech", key: "tech_startup"),
        Industry(displayName: "Finance/Fintech", image: "finance", key: "finance_professional"),
        Industry(displayName: "Health/Wellness", image: "health", key: "health_wellness"),
        Industry(displayName: "Retail/Commerce", image: "retail", key: "retail_ecommerce"),
        Industry(displayName: "Education", image: "edu", key: "education"),
        Industry(displayName: "Creative/Portfolio", image: "creative", key: "creative_arts"),
        Industry(displayName: "Food & Beverage", image: "food", key: "food_beverage"),
        Industry(displayName: "Travel/Hospitality", image: "travel", key: "travel_hospitality"),
        Industry(displayName: "Entertainment", image: "entertainment", key: "entertainment_media"),
        Industry(displayName: "Social/Community", image: "social", key: "social_community"),
        Industry(displayName: "Parenting/Family", image: "parenting", key: "kids_toys")
    ]
}
