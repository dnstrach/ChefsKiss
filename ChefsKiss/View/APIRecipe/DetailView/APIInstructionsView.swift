//
//  APIInstructionsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIInstructionsView: View {
    @Environment(\.openURL) var openURL
    
    let recipe: APIRecipe
    
    var body: some View {
        VStack {
            HStack {
                Text("Instructions")
                    .subtitleFont()
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.bottom, 2)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                // analyzed instructions has more than one steps []
                if let instructions = recipe.analyzedInstructions, !instructions.isEmpty {
                    ForEach(Array(instructions.flatMap { $0.steps }.enumerated()), id: \.element.step) { index, step in
                        
                        if index == 0 {
                            LineDividerView()
                        }
                        
                        HStack {
                            Text("\(index + 1).")
                                .foregroundStyle(Color.accent)
                                .font(.title2)
                                .fontDesign(.rounded)
                                .bold()
                            Text("\(step.step)")
                                .contentFont()
                            
                            Spacer()
                            
                        }
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.trailing)
                        
                        LineDividerView()
                        
                    }
                } else {
                    HStack {
                        Text("No instructions listed")
                            .contentFont()
                            .foregroundColor(.gray)
                            .padding(.leading)
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APIInstructionsView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
