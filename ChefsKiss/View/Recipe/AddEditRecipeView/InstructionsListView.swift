//
//  InstructionsListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct InstructionsListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        List {
            if !viewModel.instructions.isEmpty {
                EditButton()
                
            }
            
            ForEach(Array(viewModel.sortedInstructions.enumerated()), id: \.offset) { index, instruction in
                Text("\(index + 1). \(instruction.step)")
                    .onTapGesture {
                        viewModel.selectedInstruction = instruction
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteStep(instruction)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                
            }
            .onMove(perform: viewModel.moveStep)
            //  .onDelete(perform: deleteStep)
        }
        .sheet(item: $viewModel.selectedInstruction) { instruction in
            EditInstructionSheetView(viewModel: viewModel, instruction: instruction)
                .presentationDetents([.fraction(0.25)])
                .presentationDragIndicator(.hidden)
        }
        
        VStack {
            HStack {
                TextField("Step", text: $viewModel.step, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
            }
            
            Button("Add Step", systemImage: "plus.circle") {
                viewModel.addStep(at: viewModel.instructions.count)
                UIApplication.shared.endEditing()
            }
            .disabled(viewModel.disableStep)
        }

    }
}

#Preview {
    Form {
        InstructionsListView(viewModel: AddEditRecipeViewModel())
    }
}
