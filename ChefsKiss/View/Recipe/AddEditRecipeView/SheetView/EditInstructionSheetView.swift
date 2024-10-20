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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Step", text: $step, axis: .vertical)
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
            }
            
            Button("Edit Step", systemImage: "plus.circle") {
                editInstruction(instruction)
                dismiss()
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
//    EditInstructionSheetView()
//}
