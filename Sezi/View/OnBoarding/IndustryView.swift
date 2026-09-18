//
//  IndustryView.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct IndustryView: View {
    @Bindable var viewModel: OnBoardingViewModel
    @State private var progress = 0.6
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundColors
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                ProgressView(value: progress)
                    .tint(Color.tertiaryColors)
                
                Text("What's your project about?")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.vertical, 10)
                    .padding(.bottom, 10)
                
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(Industry.allIndustry, id: \.id) { industry in
                        MiniCardIndustry(
                            industry: industry,
                            isSelected: viewModel.selectedIndustry?.id == industry.id
                        )
                        .opacity(viewModel.selectedIndustry == nil || viewModel.selectedIndustry?.id == industry.id ? 1.0 : 0.4)
                        .onTapGesture {
                            viewModel.toggleIndustry(industry)
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Text("Back")
                            .bold()
                            .padding(7)
                            .frame(maxWidth: .infinity)

                    }
                    .buttonStyle(.glass)
                    .tint(Color.primaryColors)
                    
                    NavigationLink(value: OnBoardingRoute.personality) {
                        Text("Continue")
                            .bold()
                            .padding(7)
                            .foregroundStyle(Color.backgroundColors)
                            .frame(maxWidth: .infinity)

                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color.primaryColors)
                    .disabled(viewModel.selectedIndustry == nil)
                }
            }
            .padding(20)
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .navigationBarBackButtonHidden(true)
        }
    }
}
