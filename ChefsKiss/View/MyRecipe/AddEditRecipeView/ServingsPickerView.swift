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
            
            Text("\(viewModel.servings.formatted())")
                .padding(.horizontal, 8)
            
            Button {
                if viewModel.servingsGreaterThanMinimum {
                    viewModel.servings -= 0.5
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.accent)
                        .opacity(0.1)
                    
                    Text("-")
                        .foregroundStyle(.accent)
                        .font(.title)
                }
                .frame(width: 30, height: 30)
            }
            .buttonStyle(PlainButtonStyle())
            
            
            Button {
                viewModel.servings += 0.5
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.accent)
                        .opacity(0.1)
                    
                    Text("+")
                        .foregroundStyle(.accent)
                        .font(.title)
                }
                .frame(width: 30, height: 30)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
    }
}

#Preview {
    ServingsPickerView(viewModel: AddEditRecipeViewModel())
}
