//
//  InstructionsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct InstructionsView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Instructions")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.bottom)
                
                ForEach(recipe.sortedInstructions, id: \.id) { step in
                    Text("\(step.index + 1). \(step.step)")
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return InstructionsView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
