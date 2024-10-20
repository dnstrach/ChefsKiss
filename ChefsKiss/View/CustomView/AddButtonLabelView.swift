//
//  AddButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/20/24.
//

import SwiftUI

struct AddButtonLabelView: View {
    var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.accent)
                .overlay(Capsule().stroke(.white))
                .shadow(
                    color: .white.opacity(0.5),
                    radius: 10, x: 0, y: 0
                )
            
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                
                Text("\(text)")
                    .font(.subheadline)
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
    AddButtonLabelView(text: "Add Ingredient")
}
