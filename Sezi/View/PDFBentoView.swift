//
//  PDFBentoView.swift
//  Sezi
//
//  Created by Yimei Winata on 15/09/26.
//

import SwiftUI

struct PDFBentoView: View {
    let palette: ColorPalette
    let pairing: FontPairing
    
    private var headingFamily: String {
        pairing.headingFont
    }
    
    private var bodyFamily: String {
        pairing.bodyFont
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColors
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                VStack(spacing: 10) {
                    Text("Design System")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(Color.primaryColors)
                    
                    Text("Your recommended color palette and typography system")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.primaryColors.opacity(0.7))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(alignment: .top, spacing: 20) {
                    HStack(spacing: 8) {
                        //colors
                        VStack(spacing: 10) {
                            Text("Colors")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.primaryColors)
                            
                            GeometryReader { geo in
                                VStack(spacing: 0) {
                                    ForEach(Array(palette.asArray.enumerated()), id: \.offset) { index, item in
                                        let blockHeight = geo.size.height * item.weight
                                        colorBlock(hex: item.swatch.hex.uppercased(), label: item.label, color: item.swatch.color, textColor: item.swatch.textColor, topRadius: index == 0 ? 10 : 0, bottomRadius: index == palette.asArray.count - 1 ? 10 : 0, availableHeight: blockHeight
                                        )
                                        .frame(height: blockHeight)
                                    }
                                }
                            }
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                        }
                        
                        VStack(spacing: 10) {
                            Text("Color Blindness Preview")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.primaryColors)
                            
                            //colors
                            GeometryReader { geo in
                                VStack(spacing: 0) {
                                    ForEach(Array(palette.asArray.enumerated()), id: \.offset) { index, item in
                                        let blockHeight = geo.size.height * item.weight
                                        colorBlock(hex: item.swatch.hex.uppercased(), label: item.label, color: item.swatch.color, textColor: item.swatch.textColor, topRadius: index == 0 ? 10 : 0, bottomRadius: index == palette.asArray.count - 1 ? 10 : 0, availableHeight: blockHeight
                                        )
                                        .frame(height: blockHeight)
                                    }
                                }
                            }
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                            .grayscale(1)
                        }
                    }
                    
                    VStack(spacing: 8) {
                        VStack {
//                            Text("Typography")
//                                .font(.system(size: 12, weight: .medium))
//                                .foregroundStyle(Color.primaryColors)
//                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            
                            HStack(spacing: 12) {
                                fontCard(title: "Heading", sample: "Aa", fontName: pairing.headingFont, font: headingFamily)
                                
                                fontCard(title: "Body", sample: "Aa", fontName: pairing.bodyFont, font: bodyFamily)
                            }
                        }
                        
                        HStack(spacing: 8) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Example Heading")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.primaryColors.opacity(0.6))
                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundStyle(Color.primaryColors)
                                
                                Text("Large Title")
                                    .font(.custom(named: headingFamily, size: 34))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                
                                Text("Title 1")
                                    .font(.custom(named: headingFamily, size: 28))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                
                                Text("Title 2")
                                    .font(.custom(named: headingFamily, size: 22))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                
                                Text("Title 3")
                                    .font(.custom(named: headingFamily, size: 20))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.secondaryColors, style: StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                            )
                            
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Example Body")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.primaryColors.opacity(0.6))
                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundStyle(Color.primaryColors)
                                
                                Text("Body")
                                    .font(.custom(named: bodyFamily, size: 17))
                                
                                Text("Callout")
                                    .font(.custom(named: bodyFamily, size: 16))
                                
                                Text("Subhead")
                                    .font(.custom(named: bodyFamily, size: 15))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.secondaryColors, style: StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .padding(40)
            .frame(width: 842, height: 595)
        }
    }
    
    @ViewBuilder
    private func fontCard(title: String, sample: String, fontName: String, font: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            //nama font
            Text(title)
                .foregroundStyle(Color.primaryColors)
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 12)
                .padding(.top, 8)
            
            Text(sample)
                .foregroundStyle(Color.primaryColors.opacity(0.5))
                .font(.custom(font, size: 40))
                .frame(maxWidth: .infinity, alignment: .center)
                
            
            Text(fontName)
                .foregroundStyle(Color.primaryColors)
                .font(.custom(font, size: 20, relativeTo: .headline))
                .frame(maxWidth: .infinity, alignment: .center)
           
        }
        
        .frame(height: 150, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.secondaryColors, style: StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
        )
    }
    
    @ViewBuilder
    private func colorBlock(hex: String, label: String, color: Color, textColor: Color, topRadius: CGFloat, bottomRadius: CGFloat, availableHeight: CGFloat) -> some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: topRadius,
                bottomLeadingRadius: bottomRadius,
                bottomTrailingRadius: bottomRadius,
                topTrailingRadius: topRadius
            )
                .fill(color)
            
            VStack(spacing: 2) {
                Text(hex)
                    .font(.system(size: 20, weight: .black))
                Text(label)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(textColor)
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
        }
    }
}
