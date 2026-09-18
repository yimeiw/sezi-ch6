//
//  ColorPalette.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import Foundation
import CoreGraphics

struct ColorPalette {
    let primary: ColorSwatch
    let secondary: ColorSwatch
    let tertiary: ColorSwatch
    let accent: ColorSwatch
}

extension ColorPalette {
    static let primaryWeight: CGFloat = 0.60
    static let secondaryWeight: CGFloat = 0.20
    static let tertiaryWeight: CGFloat = 0.10
    static let accentWeight: CGFloat = 0.10
    
    var asArray: [(swatch: ColorSwatch, label: String, weight: CGFloat)] {
        [
            (primary, "Primary", Self.primaryWeight),
            (secondary, "secondary", Self.secondaryWeight),
            (tertiary, "Tertiary", Self.tertiaryWeight),
            (accent, "Accent", Self.accentWeight)
        ]
    }
}
