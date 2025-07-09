//
//  InstructionsListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/22/24.
//

import SwiftUI

struct InstructionsListView: View {
   @Binding var instructions: [Recipe.Instruction]
    let deleteCallback: (IndexSet) -> ()
    
    var body: some View {
        List {
            ForEach(instructions, id: \.id) { step in
                Text("\(step.step)")
            }
            .onDelete(perform: deleteCallback)
        }
    }
}

//#Preview {
//    @State var sampleInstructions: [Recipe.Instruction] = [
//        Recipe.Instruction(step: "Step 1"),
//        Recipe.Instruction(step: "Step 2")
//    ]
//    
//    let deleteCallback: (IndexSet) -> ()
//    
//    InstructionsListView(instructions: $sampleInstructions, deleteCallback: deleteCallback)
//}
