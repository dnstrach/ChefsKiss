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
    
    let showAddImage: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                TextField("",
                          text: $viewModel.step,
                          prompt: Text("Step").foregroundStyle(.accent),
                          axis: .vertical
                )
                .textfieldStyle()
                .padding(.horizontal)
            }
            
            Button {
                viewModel.addStep(at: viewModel.instructions.count)
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Add Step")
            }
            .disabled(viewModel.disableStep)
        }
        .onDisappear {
            viewModel.clearStep()
        }
        .padding(.vertical)
    }
}

#Preview {
    AddInstructionView(viewModel: AddEditRecipeViewModel())
}
