//
//  PaletteGenerator.swift
//  Sezi
//
//  Created by Yimei Winata on 15/09/26.
//

import Foundation

enum PaletteGenerator {
    private static let minHueDistance: Double = 25
    private static let complementaryHueDistance: Double = 130
    private static let minlightnessDistance: Double = 0.15
    private static let minCVDDistance: Double = 0.12
    private static let maxLightnessBoostOverPrimary: Double = 0.20
    
    static func generate(colors: [ColorSwatch], target: TargetUser?, industry: Industry?, personalities: [Personality], weights: ScoringWeights) -> ColorPalette? {
        
        guard !colors.isEmpty else{
            return nil
        }
        
        let ranked = colors.map {
            (swatch: $0, score: ScoringEngine.score(color: $0, target: target, industry: industry, personalities: personalities, weights: weights))
        }.sorted { $0.score > $1.score }
        
        guard let primary = ranked.first?.swatch else {
            return nil
        }
        var chosen: [ColorSwatch] = [primary]
        
        
        let secondary = pickNext(from: ranked, avoiding: chosen, primary: primary) ?? primary
        chosen.append(secondary)
        
        let tertiary = pickNext(from: ranked, avoiding: chosen, primary: primary) ?? secondary
        chosen.append(tertiary)
        
        let accent = ranked.filter { !chosen.contains($0.swatch) }
            .filter { hueDistance($0.swatch.hue, primary.hue) >= complementaryHueDistance }
            .sorted { $0.swatch.saturation > $1.swatch.saturation }
            .first?.swatch
        ?? pickNext(from: ranked, avoiding: chosen, primary: primary)
        ?? tertiary
        
        return ColorPalette(primary: primary, secondary: secondary, tertiary: tertiary, accent: accent)
    }
    
    private static func pickNext(from ranked: [(swatch: ColorSwatch, score: Double)], avoiding chosen: [ColorSwatch], primary: ColorSwatch) -> ColorSwatch? {
        
        let candidates = ranked.filter { !chosen.contains($0.swatch) }
        
        guard !candidates.isEmpty else {
            return nil
        }
        
        if let distinct = candidates.first(where: { isDistinct($0.swatch, from: chosen, primary: primary) }) {
            return distinct.swatch
        }
        
        return candidates.max {
            minCVDDistance($0.swatch, from: chosen) <
            minCVDDistance($1.swatch, from: chosen)
        }?.swatch
    }
    
    private static func isDistinct(_ candidate: ColorSwatch, from chosen: [ColorSwatch], primary: ColorSwatch) -> Bool {
        guard isSafeLightness(candidate, primary: primary) else {
            return false
        }
        
        return chosen.allSatisfy { existing in
            hueDistance(existing.hue, candidate.hue) >= minHueDistance &&
            abs(existing.lightness - candidate.lightness) >= minlightnessDistance &&
            cvdDistance(existing, candidate) >= minCVDDistance
        }
    }
    
    private static func isSafeLightness(_ candidate: ColorSwatch, primary: ColorSwatch) -> Bool {
        candidate.lightness <= primary.lightness + maxLightnessBoostOverPrimary
    }
    
    private static func hueDistance(_ a: Double, _ b: Double) -> Double {
        let diff = abs(a - b).truncatingRemainder(dividingBy: 360)
        return diff > 180 ? 360 - diff : diff
    }
    
    private static func cvdDistance(_ a: ColorSwatch, _ b: ColorSwatch) -> Double {
        let simA = simulateCVD(hslToRGB(hue: a.hue, saturation: a.saturation, lightness: a.lightness))
        let simB = simulateCVD(hslToRGB(hue: b.hue, saturation: b.saturation, lightness: b.lightness))
        
        let dr = simA.r - simB.r
        let dg = simA.g - simB.g
        let db = simA.b - simB.b
        return(dr * dr + dg * dg + db * db).squareRoot()
    }
    
    private static func simulateCVD(_ rgb: (r: Double, g: Double, b: Double)) -> (r: Double, g: Double, b: Double) {
        let protan = (
            r: 0.567 * rgb.r + 0.433 * rgb.g + 0.000 * rgb.b,
            g: 0.558 * rgb.r + 0.442 * rgb.g + 0.000 * rgb.b,
            b: 0.000 * rgb.r + 0.242 * rgb.g + 0.758 * rgb.b
        )
        
        let deutan = (
            r: 0.625 * rgb.r + 0.375 * rgb.g + 0.000 * rgb.b,
            g: 0.700 * rgb.r + 0.300 * rgb.g + 0.000 * rgb.b,
            b: 0.000 * rgb.r + 0.300 * rgb.g + 0.700 * rgb.b
        )
        
        let simulatedLinear = (
            r: (protan.r + deutan.r) / 2,
            g: (protan.g + deutan.g) / 2,
            b: (protan.b + deutan.b) / 2
        )
        
        return (
            r: gammaEncode(simulatedLinear.r),
            g: gammaEncode(simulatedLinear.g),
            b: gammaEncode(simulatedLinear.b)
        )
    }
    
    private static func hslToRGB(hue: Double, saturation: Double, lightness: Double) -> (r: Double, g: Double, b: Double) {
        let h = hue/360
        let s = saturation
        let l = lightness
        
        guard s > 0 else {
            return (l,l,l)
        }
        
        func hueToRGB(_ p: Double, _ q: Double, _ t: Double) -> Double {
            var t = t
            if t < 0 {
                t += 1
            }
            
            if t > 1 {
                t -= 1
            }
            
            if t < 1 / 6 {
                return p + (q - p) * 6 * t
            }
            
            if t < 1 / 2 {
                return q
            }
            
            if t < 2 / 3 {
                return p + (q - p) * (2 / 3 - t) * 6
            }
            
            return p
        }
        
        let q = l < 0.5 ? l * (1 + s) : l + s - l * s
        let p = 2 * l - q
        return (
            r: hueToRGB(p, q, h + 1/3),
            g: hueToRGB(p, q, h),
            b: hueToRGB(p, q, h - 1/3)
        )
    }
    
    private static func linearize(_ c: Double) -> Double {
        let c = min(max(c, 0), 1)
        return c <= 0.04045 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
    }
    
    private static func gammaEncode(_ c: Double) -> Double {
        let c = min(max(c, 0), 1)
        return c <= 0.0031308 ? c * 12.92 : 1.055 * pow(c, 1 / 2.4) - 0.055
    }
    
    private static func minCVDDistance(_ candidate: ColorSwatch, from chosen: [ColorSwatch]) -> Double {
        chosen.map { cvdDistance($0, candidate) }.min() ?? .infinity
    }
}
