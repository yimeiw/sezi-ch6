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
                .cornerRadius(10)
                .frame(width: 115, height: 116)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.secondaryColors : Color.clear, lineWidth: isSelected ? 3 : 0)
                )
            
            VStack {
                Spacer()
                Text(personality.displayName)
                    .foregroundStyle(Color.primaryColors)
                    .padding(.horizontal, 10)
                    .frame(height: 26)
                    .font(.system(size: 9, weight: .bold))
//                    .background(
//                        RoundedRectangle(cornerRadius: 15)
//                            .fill(.backgroundColors)
//                    )
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color.secondaryColors : Color.backgroundColors)
                        .stroke(.secondaryColors, lineWidth: 1)
                        .frame(width: 30, height: 30)
                        .overlay {
                            if isSelected {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.backgroundColors)
                            }
                        }
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(width: 100, height: 100)        
    }
}

//#Preview {
//    MiniCard(industry: Industry.allIndustry[0])
//}
