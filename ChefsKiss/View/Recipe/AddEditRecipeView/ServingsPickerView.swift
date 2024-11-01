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
        VStack {
            Stepper("Serves \(viewModel.servings.formatted())", value: $viewModel.servings, in: 0...100, step: 0.5)
        }
    }
}

#Preview {
    ServingsPickerView(viewModel: AddEditRecipeViewModel())
}
