//
//  MiniCard.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct MiniCardPersonality: View {
    let personality: Personality
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Image(personality.image)
                .resizable()
                .frame(width: 116, height: 125)
            
            VStack {
                Spacer()
                Text(personality.displayName)
                    .foregroundStyle(Color.primaryColors)
                    .padding(.horizontal, 10)
                    .frame(height: 26, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 9, weight: .bold))
            }
            .padding(.bottom, 5)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Circle()
                        .fill(isSelected ? Color.secondaryColors : Color.backgroundColors)
                        .stroke(.secondaryColors, lineWidth: 1)
                        .frame(width: 20, height: 20)
                        .overlay {
                            if isSelected {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.backgroundColors)
                                    .font(.system(size: 9, weight: .bold))
                            }
                        }
                }
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
        }
        .frame(width: 100, height: 100)        
    }
}
