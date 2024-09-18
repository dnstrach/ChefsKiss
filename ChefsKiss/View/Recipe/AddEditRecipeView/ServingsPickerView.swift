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
        Stepper("Serves \(viewModel.servings.formatted())", value: $viewModel.servings, in: 1...100, step: 0.5)
    }
}

#Preview {
    ServingsPickerView(viewModel: AddEditRecipeViewModel())
}
