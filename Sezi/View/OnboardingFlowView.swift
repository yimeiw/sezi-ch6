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
        NavigationStack {
            TargetUserView(viewModel: viewModel)
        }
    }
}

#Preview {
    OnboardingFlowView()
}
