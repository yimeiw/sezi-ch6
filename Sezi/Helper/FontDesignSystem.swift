//
//  FontDesignSystem.swift
//  Sezi
//
//  Created by Yimei Winata on 15/09/26.
//

import Foundation
import SwiftUI
import UIKit

extension Font {
    static func custom(named familyName: String, size: CGFloat, weight: Font.Weight = .regular) -> Font {
        
        guard !familyName.isEmpty, let postScriptName = resolvedPostScriptName(forFamily: familyName) else {
            return .system(size: size, weight: weight)
        }
        return .custom(postScriptName, size: size)
    }
    
    private static func resolvedPostScriptName(forFamily familyName: String) -> String? {
        #if canImport(UIKit)
        if let exactMatch = UIFont(name: familyName, size: 12) {
            return exactMatch.fontName
        }
        
        if let family = UIFont.familyNames.first(where: { $0.caseInsensitiveCompare(familyName) == .orderedSame }) {
            return UIFont.fontNames(forFamilyName: family).first
        }
        return nil
        #else
        return nil
        #endif
    }
}
