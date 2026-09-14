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
        VStack(alignment: .leading, spacing: 30) {
            ProgressView(value: progress)
                .tint(Color.tertiaryColors)
            
            Text("Who is your target user?")
                .font(.system(size: 24, weight: .bold))
            
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(Industry.allIndustry, id: \.id) { industry in
                    MiniCardIndustry(
                        industry: industry,
                        isSelected: viewModel.selectedIndustry?.id == industry.id
                    )
                    .onTapGesture {
                        viewModel.selectedIndustry = industry
                    }
                }
            }
            
            NavigationLink {
                PersonalityView(viewModel: viewModel)
            } label: {
                Text("Continue")
                    .bold()
                    .foregroundStyle(Color.backgroundColors)
            }
            .buttonStyle(.glassProminent)
            .tint(Color.primaryColors)
            .frame(maxWidth: .infinity, alignment: .center)
            .disabled(viewModel.selectedIndustry == nil)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
    }
}
