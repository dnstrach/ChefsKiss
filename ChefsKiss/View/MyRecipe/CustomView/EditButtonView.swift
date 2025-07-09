//
//  EditButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/8/24.
//

import SwiftUI

struct EditButtonView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    var body: some View {
        Button {
            viewModel.isEditViewPresented.toggle()
        } label: {
            ZStack {
                Capsule()
                    .fill(.accent)
                    .frame(width: 50, height: 30)
                
                Text("Edit")
                    .foregroundStyle(.white)
            }
            .frame(width: 80, height: 80)
            .offset(x: -10, y: 10)
        }
    }
}

#Preview {
    EditButtonView(viewModel: RecipeDetailViewModel())
}
