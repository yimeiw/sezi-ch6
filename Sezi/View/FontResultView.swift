//
//  FontResultView.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct FontResultView: View {
    @Bindable var viewModel: OnBoardingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showExport = false
    
    private var pairing: FontPairing? { viewModel.generatedFontPairing }
    private var headingFamily: String { pairing?.headingFont ?? "" }
    private var bodyFamily: String { pairing?.bodyFont ?? "" }
    
    var body: some View {
        ZStack {
            Color.backgroundColors
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                         Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(Color.primaryColors)
                    }
                    .buttonStyle(.glass)
                    
                    Spacer()
                    Text("Typography")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.primaryColors)
                    Spacer()
                    Image(systemName: "chevron.left")
                       .font(.system(size: 20, weight: .medium))
                       .opacity(0)
                    
                }
                .padding(.bottom, 10)
                
                Text("A headline and body font, chosen to work together")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.primaryColors)
                    
                
                VStack(alignment: .leading, spacing: 20) {
                    //heading font
                    VStack(spacing: 10) {
                        Text("HEADING")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.backgroundColors)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(pairing?.headingFont ?? "Generating...")
                            .foregroundStyle(Color.backgroundColors)
                            .font(.custom(named: headingFamily, size: 20, weight: .black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    //body font
                    VStack(spacing: 10) {
                        Text("BODY")
                            .font(.system(size: 13, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.backgroundColors)
                        Text(pairing?.bodyFont ?? "Generating...")
                            .foregroundStyle(Color.backgroundColors)
                            .font(.custom(named: bodyFamily, size: 20, weight: .black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.primaryColors)
                )
                
                VStack(alignment: .leading) {
                    Text("HEADING")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color.primaryColors.opacity(0.6))
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .tint(Color.primaryColors)
                    
                    VStack(spacing: 8) {
                        headingSampleRow("Large Title", size: 34)
                        headingSampleRow("Title 1", size: 28)
                        headingSampleRow("Title 2", size: 22)
                        headingSampleRow("Title 3", size: 20)
                    }
                }
                .padding(.top, 12)
                
                VStack(alignment: .leading) {
                    Text("BODY")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color.primaryColors.opacity(0.6))
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .tint(Color.primaryColors)
                    
                    VStack(spacing: 8) {
                        bodySampleRow("Body", size: 17)
                        bodySampleRow("Callout", size: 16)
                        bodySampleRow("Subhead", size: 15)
                    }
                }
                .padding(.top, 12)
                
                HStack {
                    Button {
                        viewModel.resetToStart()
                    } label: {
                        Text("Generate New")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(Color.backgroundColors)
                            .frame(maxWidth: .infinity)
                            .padding(5)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color.tertiaryColors)
                    
                    Button {
                        if let palette = viewModel.generatedPalette, let pairing = viewModel.generatedFontPairing {
                            PDFExporter.export(palette: palette, pairing: pairing)
                        }
                    } label: {
                        Text("Export")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(Color.backgroundColors)
                            .frame(maxWidth: .infinity)
                            .padding(7)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color.primaryColors)
                }
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
    private func headingSampleRow(_ label: String, size: CGFloat) -> some View {
        HStack {
            Text(label)
                .font(.custom(named: headingFamily, size: size))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text("\(Int(size))px")
                .font(.custom(named: headingFamily, size: size))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
    
    @ViewBuilder
    private func bodySampleRow(_ label: String, size: CGFloat) -> some View {
        HStack {
            Text(label)
                .font(.custom(named: bodyFamily, size: size))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text("\(Int(size))px")
                .font(.custom(named: bodyFamily, size: size))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
}
