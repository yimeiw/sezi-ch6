//
//  TargetUser.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation

struct TargetUser {
    let id: UUID = UUID()
    let displayName: String
    let image: String
    let key: String
}

extension TargetUser {
    static let allTarget: [TargetUser] = [
        TargetUser(displayName: "Kids (Age 5 - 11)", image: "kids-icon", key: "kids"),
        TargetUser(displayName: "Teens (Age 12 - 25)", image: "teens-icon", key: "teens"),
        TargetUser(displayName: "Adults (Age 26 - 45)", image: "adults-icon", key: "adults")
    ]
}
