//
//  AddButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/20/24.
//

import SwiftUI

struct SheetButtonLabelView: View {
    var isAddItem: Bool
    
    var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(
                    .accent1
                )
                .overlay(Capsule().stroke(.white))
                .shadow(color: Color.shadow, radius: 5)
            
            HStack {
                Image(systemName: isAddItem ? "plus.circle.fill" : "pencil.circle")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                
                Text("\(text)")
                    .contentFont()
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)
        }
        .frame(width: 200, height: 50)
        .padding()
    }
}

#Preview {
    SheetButtonLabelView(isAddItem: true, text: "Add Ingredient")
}
