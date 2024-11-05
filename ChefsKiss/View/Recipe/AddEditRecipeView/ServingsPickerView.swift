//
//  ServingsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct ServingsPickerView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        HStack {
            Text("SERVINGS")
                .foregroundStyle(.accent)
                .font(.footnote)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                viewModel.servings -= 0.5
                print("- button tapped")
            } label: {
                Image(systemName: "minus.rectangle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.accent)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("\(viewModel.servings.formatted())")
            
            Button {
                viewModel.servings += 0.5
                print("+ button tapped")
            } label: {
                Image(systemName: "plus.rectangle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.accent)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
    }
}

#Preview {
    ServingsPickerView(viewModel: AddEditRecipeViewModel())
}
