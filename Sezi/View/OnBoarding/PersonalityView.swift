//
//  PersonalityView.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct PersonalityView: View {
    @Bindable var viewModel: OnBoardingViewModel
    @State private var progress = 1.0
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundColors
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                ProgressView(value: progress)
                    .tint(Color.tertiaryColors)
                
                Text("Choose up to 3 personalities")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.vertical, 10)
                    .padding(.bottom, 10)
                
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(Personality.allPersonality, id: \.id) { personality in
                        MiniCardPersonality(
                            personality: personality,
                            isSelected: viewModel.selectedPersonalities.contains(where: { $0.id == personality.id })
                        )
                        .opacity(canTap(personality) ? 1.0 : 0.4)
                        .onTapGesture {
                            viewModel.togglePersonality(personality)
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
                    
                    NavigationLink(value: OnBoardingRoute.colorResult) {
                        Text("See Result")
                            .bold()
                            .padding(7)
                            .foregroundStyle(Color.backgroundColors)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color.primaryColors)
                    .disabled(viewModel.selectedPersonalities.isEmpty)
                }
                
            }
            .padding(20)
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func canTap(_ personality: Personality) -> Bool {
        viewModel.selectedPersonalities.contains(where: { $0.id == personality.id }) || viewModel.selectedPersonalities.count < 3
    }
}
