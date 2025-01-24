//
//  EditInstructionSheetView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/19/24.
//

import SwiftUI

struct EditInstructionSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var instruction: Recipe.Instruction
    @State var step: String = ""
    
    let showAddImage: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("",
                          text: $step,
                          prompt: Text("Step").foregroundStyle(.accent),
                          axis: .vertical
                )
                .textfieldStyle()
                .padding(.horizontal)
            }
            
            Button {
                editInstruction(instruction)
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Edit Step")
            }
        }
        .padding(.vertical)
        .onAppear {
            storeInitialStep(instruction)
        }
    }
    
    func storeInitialStep(_ instruction: Recipe.Instruction) {
        step = instruction.step
    }
    
    func editInstruction(_ instruction: Recipe.Instruction) {
        instruction.step = step
    }
}

//#Preview {
//    EditInstructionSheetView(viewModel: AddEditRecipeViewModel(), instruction: <#Recipe.Instruction#>)
//}
