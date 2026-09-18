//
//  OnboardingFlowView.swift
//  Sezi
//
//  Created by Yimei Winata on 14/09/26.
//

import SwiftUI

struct OnboardingFlowView: View {
    @State private var viewModel = OnBoardingViewModel()
    var body: some View {
        NavigationStack(path: Bindable(viewModel).path) {
            TargetUserView(viewModel: viewModel)
                .navigationDestination(for: OnBoardingRoute.self) { route in
                    switch route {
                    case .industry:
                        IndustryView(viewModel: viewModel)
                        
                    case .personality:
                        PersonalityView(viewModel: viewModel)
                        
                    case .colorResult:
                        ColorResultView(viewModel: viewModel)
                        
                    case .fontResult:
                        FontResultView(viewModel: viewModel)
                    }
                }
        }
    }
}

#Preview {
    OnboardingFlowView()
}
