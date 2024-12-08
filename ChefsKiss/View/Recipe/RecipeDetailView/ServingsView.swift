//
//  RecipeServingsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct ServingsView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.accent)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                .frame(maxWidth: 100)
            
            VStack(spacing: 0) {
                Text("Serves")
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                HStack {
                    Image("forkKnife")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("\(recipe.servings.formatted())")
                        .contentFont()
                    
                }
            }
            .padding(.vertical, 5)
            .foregroundStyle(.white)
        }
    }
}

//#Preview {
//    do {
//        let preview = try RecipePreview()
//        
//        return ServingsView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
//            .modelContainer(preview.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
