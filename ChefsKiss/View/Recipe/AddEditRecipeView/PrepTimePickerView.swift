//
//  TimePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct PrepTimePickerView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        HStack {
            Text("PREP TIME")
                .foregroundStyle(.accent)
                .font(.footnote)
                .fontWeight(.bold)
            
            Picker("", selection: $viewModel.prepTime) {
                ForEach(viewModel.prepTimeRange, id: \.self) { min in
                    Text("\(min)")
                }
            }
        }
    }
}

#Preview {
    Form {
        Section {
            PrepTimePickerView(viewModel: AddEditRecipeViewModel())
        }
    }
}
