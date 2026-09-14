//
//  PersonalityView.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct PersonalityView: View {
    @Bindable var viewModel: OnBoardingViewModel
    @State private var progress = 0.9
    
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
                ForEach(Personality.allPersonality, id: \.id) { personality in
                    MiniCardPersonality(
                        personality: personality,
                        isSelected: viewModel.selectedPersonality?.id == personality.id
                    )
                    .onTapGesture {
                        viewModel.selectedPersonality = personality
                    }
                }
            }
            
            Button {
                //continue to industry
            } label: {
                Text("See Result")
                    .bold()
                    .foregroundStyle(Color.backgroundColors)
            }
            .buttonStyle(.glassProminent)
            .tint(Color.primaryColors)
            .frame(maxWidth: .infinity, alignment: .center)
            .disabled(viewModel.selectedPersonality == nil)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    PersonalityView()
//}
