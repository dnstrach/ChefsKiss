//
//  AddInstructionView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/20/24.
//

import SwiftUI

struct AddInstructionView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        VStack {
            HStack {
                TextField("Step", text: $viewModel.step, axis: .vertical)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
            }
            
            Button {
                viewModel.addStep(at: viewModel.instructions.count)
                dismiss()
            } label: {
                AddButtonLabelView(text: "Add Step")
            }
            .disabled(viewModel.disableStep)
        }
        .padding(.vertical)
    }
}

#Preview {
    AddInstructionView(viewModel: AddEditRecipeViewModel())
}
