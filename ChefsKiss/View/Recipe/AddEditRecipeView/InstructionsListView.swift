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
            
            ForEach(Array(viewModel.sortedInstructions.enumerated()), id: \.offset) { index, step in
                Text("\(index + 1). \(step.step)")
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteStep(step)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                
            }
            .onMove(perform: viewModel.moveStep)
            //  .onDelete(perform: deleteStep)
        }
        
        VStack {
            HStack {
                TextField("Step", text: $viewModel.step, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
            }
            
            Button("Add Step", systemImage: "plus.circle") {
                viewModel.addStep(at: viewModel.instructions.count)
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
