//
//  InstructionsListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct InstructionsListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var showAddInstructionSheet: Bool = false
    
    var body: some View {
        HStack {
            Text("INSTRUCTIONS")
                .foregroundStyle(.accent)
                .font(.footnote)
                .fontWeight(.bold)
            
            Spacer()
            
            PlusButtonView(showSheet: $showAddInstructionSheet)
            
//            Spacer()
        }
        .sheet(isPresented: $showAddInstructionSheet) {
            AddInstructionView(viewModel: viewModel)
                .sheetBackground()
        }
        
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
        }
      //  .listRowBackground(Color.textfield)
    }
}

#Preview {
    Form {
        InstructionsListView(viewModel: AddEditRecipeViewModel())
    }
}
