//
//  CookTimePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct CookTimePickerView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        HStack {
            Text("COOK TIME")
                .foregroundStyle(.accent)
                .font(.footnote)
                .fontWeight(.bold)
            
            Picker("", selection: $viewModel.cookTime) {
                ForEach(viewModel.cookTimeRange, id: \.self) { min in
                    Text("\(min)")
                }
                .foregroundStyle(.accent1)
            }
            
            Text(viewModel.cookTime == 1 ? "minute" : "minutes")
        }
    }
}

#Preview {
    Form {
        Section {
            CookTimePickerView(viewModel: AddEditRecipeViewModel())
        }
    }
}

