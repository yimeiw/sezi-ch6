//
//  TargetUserView.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct TargetUserView: View {
    @Bindable var viewModel: OnBoardingViewModel
    @State private var progress = 0.3
    
    var body: some View {
        ZStack {
            Color.backgroundColors
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                ProgressView(value: progress)
                    .tint(Color.tertiaryColors)
                
                Text("Who is your app's target user?")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.vertical, 10)
                
                VStack(spacing: 4) {
                    ForEach(TargetUser.allTarget, id: \.id) { target in
                        TargetUserCard(
                            target: target,
                            isSelected: viewModel.selectedTargetUser?.id == target.id
                        )
                        .opacity(viewModel.selectedTargetUser == nil || viewModel.selectedTargetUser?.id == target.id ? 1.0 : 0.4)
                        .onTapGesture {
                            viewModel.toggleTarget(target)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(value: OnBoardingRoute.industry) {
                    Text("Continue")
                        .bold()
                        .padding(7)
                        .foregroundStyle(Color.backgroundColors)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .tint(Color.primaryColors)
                .disabled(viewModel.selectedTargetUser == nil)
                
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

#Preview {
    TargetUserView(viewModel: OnBoardingViewModel())
}
