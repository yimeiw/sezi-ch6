//
//  TargetUserCard.swift
//  Sezi
//
//  Created by Yimei Winata on 13/09/26.
//

import SwiftUI

struct TargetUserCard: View {
    let target: TargetUser
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Image(target.image)
                .resizable()
                .cornerRadius(10)
                .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.secondaryColors : Color.clear, lineWidth: isSelected ? 3 : 0)
                }
            
            VStack {
                Spacer()
                
                Text(target.displayName)
                    .foregroundStyle(Color.primaryColors)
                    .bold()
                    .padding(.bottom, 5)
                    
            }
            .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Circle()
                        .fill(isSelected ? Color.secondaryColors : Color.backgroundColors)
                        .stroke(.secondaryColors, lineWidth: 1)
                        .frame(width: 30, height: 30)
                        .overlay {
                            if isSelected {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.backgroundColors)
                                    .font(.system(size: 14, weight: .bold))
                            }
                        }
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
        }
        .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.secondaryColors : Color.clear, lineWidth: isSelected ? 3 : 0)
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
    }
}
