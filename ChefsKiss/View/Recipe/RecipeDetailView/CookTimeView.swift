//
//  CookTimeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/23/24.
//

import SwiftUI

struct CookTimeView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        if viewModel.showCookTime(recipe: recipe) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accent)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                    .frame(maxWidth: 200)
                
                VStack(spacing: 0) {
                    Text("Cook")
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    
                    HStack(alignment: .center) {
                        Image("clock")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("\(recipe.cookTime)")
                            .contentFont()
                        Text(recipe.cookTime == 1 ? viewModel.min : viewModel.mins)
                            .contentFont()
                    }
                }
                .foregroundStyle(.white)
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return CookTimeView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
