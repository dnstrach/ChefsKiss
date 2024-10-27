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
            Picker("Cook Time", selection: $viewModel.cookTime) {
                ForEach(viewModel.cookTimeRange, id: \.self) { min in
                    Text("\(min)")
                }
            }
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

