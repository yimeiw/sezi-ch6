//
//  MiniCard.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct MiniCardIndustry: View {
    let industry: Industry
    let isSelected: Bool
    var body: some View {
        ZStack {
            Image(industry.image)
                .resizable()
                .frame(width: 116, height: 130)
            
            VStack {
                Spacer()
                
                Text(industry.displayName)
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
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
        }
        .frame(width: 100, height: 100)
        .contentShape(Rectangle())
        
    }
}

//#Preview {
//    MiniCard(industry: Industry.allIndustry[0])
//}
