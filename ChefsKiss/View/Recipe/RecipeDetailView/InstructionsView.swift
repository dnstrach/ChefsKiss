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
                    .subtitleFont()
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.top)
                
                LineDividerView()
                
                if !recipe.sortedInstructions.isEmpty {
                    ForEach(recipe.sortedInstructions, id: \.id) { step in
                        HStack {
                            Text("\(step.index + 1).")
                                .foregroundStyle(Color.accent)
                                .font(.title2)
                                .bold()
                            
                            Text("\(step.step)")
                                .contentFont()
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                        
                        LineDividerView()
                    }
                } else {
                    Text("No instructions listed")
                        .contentFont()
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.leading)
                    
                    LineDividerView()
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
