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
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.secondaryColors : Color.clear, lineWidth: isSelected ? 3 : 0)
                }
            
            VStack {
                Spacer()
                
                Text(target.displayName)
                    .foregroundStyle(Color.primaryColors)
                    .bold()
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.backgroundColors)
                            .frame(height: 36)
                    )
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color.secondaryColors : Color.backgroundColors)
                        .stroke(.secondaryColors, lineWidth: 1)
                        .frame(width: 40, height: 40)
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
        .padding(.vertical, 10)
        .contentShape(Rectangle())
    }
}
//
//#Preview {
//    TargetUserCard(target: TargetUser.allTarget[0])
//}
