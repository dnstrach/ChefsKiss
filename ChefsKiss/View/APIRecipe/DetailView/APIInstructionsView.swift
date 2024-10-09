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
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.bottom, 2)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                // analyzed instructions has more than one steps []
                if let instructions = recipe.analyzedInstructions, !instructions.isEmpty {
                    ForEach(Array(instructions.flatMap { $0.steps }.enumerated()), id: \.element.step) { index, step in
                        
                        if index == 0 {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(Color.accent)
                                // .opacity(0.2)
                              //  .shadow(color: Color.secondary, radius: 5)
                                .padding(.horizontal)
                                .padding(.horizontal)
                        }
                        
                     //   Divider()
                        HStack {
                            Text("\(index + 1).")
                                .foregroundStyle(Color.accent)
                                .font(.title2)
                                .bold()
                            Text("\(step.step)")
                            
                            Spacer()
                            
                        }
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.trailing)
//                        .padding(.bottom)
                      
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(Color.accent)
                          //  .shadow(color: Color.secondary, radius: 5)
                          //  .opacity(0.2)
                            .padding(.horizontal)
                            .padding(.horizontal)
                     //   Divider()
                        
                    }
                } else {
                    HStack {
                        Text("No instructions available")
                            .foregroundColor(.gray)
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
