//
//  ColorResultView.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct ColorResultView: View {
    @Bindable var viewModel: OnBoardingViewModel
    @State private var vibrateOnRing = false
    
    private var palette: ColorPalette? { viewModel.generatedPalette }
    
    var body: some View {
        ZStack {
            Color.backgroundColors
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                Text("Color Palette")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.primaryColors)
                
                Text("Sized by how much each color is meant to be used")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.primaryColors)
                
                //toggle
                Toggle(isOn: $vibrateOnRing) {
                    HStack {
                        Image(systemName: "eye")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.primaryColors)
                        
                        Text("Color blindness view")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.primaryColors)
                    }
                }
                .tint(Color.primaryColors)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.backgroundHoverColors)
                )
                
                if let palette {
                    GeometryReader { geo in
                        VStack(spacing: 0) {
                            ForEach(palette.asArray, id: \.swatch.id) { entry in
                                swatchBlock(entry.swatch, label: entry.label, weight: entry.weight)
                                    .frame(height: geo.size.height * entry.weight)
                                
                            }
                        }
                    }
                    .frame(height: 420)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .grayscale(vibrateOnRing ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: vibrateOnRing)
                } else {
                    ProgressView()
                        .frame(height: 420)
                        .frame(maxWidth: .infinity)
                }
                
                NavigationLink(value: OnBoardingRoute.fontResult) {
                    Text("Continue to font")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.backgroundColors)
                        .frame(maxWidth: .infinity)
                        .padding(7)
                }
                .buttonStyle(.glassProminent)
                .tint(Color.primaryColors)
                .disabled(palette == nil)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if viewModel.generatedPalette == nil {
                viewModel.generateResults()
            }
        }
    }
    
    @ViewBuilder
    private func swatchBlock(_ swatch: ColorSwatch, label: String, weight: CGFloat) -> some View {
        let isCompact = weight <= ColorPalette.tertiaryWeight
        ZStack {
            Rectangle()
                .fill(swatch.color)
            
            VStack(spacing: 0) {
                Text(swatch.hex.uppercased())
                    .font(.system(size: isCompact ? 14 : 20, weight: .black))
                Text(label)
                    .font(.system(size: isCompact ? 10 : 13, weight: .medium))
            }
            .foregroundStyle(swatch.textColor)
        }
    }
}
