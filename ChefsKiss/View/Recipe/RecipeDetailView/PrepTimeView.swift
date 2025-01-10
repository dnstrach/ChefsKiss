//
//  PrepTimeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/23/24.
//

import SwiftUI

struct PrepTimeView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        if viewModel.showPrepTime(recipe: recipe) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accent)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                    .frame(maxWidth: 180)
                
                VStack(spacing: 0) {
                    Text("Prep")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    
                    HStack(alignment: .center) {
                        Image("clock")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("\(recipe.prepTime)")
                            .contentFont()
                        Text(recipe.prepTime == 1 ? viewModel.min : viewModel.mins)
                            .contentFont()
                    }
                }
                .padding(.vertical, 5)
                .foregroundStyle(.white)
            }
        }
    }
}

//#Preview {
//    do {
//        let preview = try RecipePreview()
//
//        return PrepTimeView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
//            .modelContainer(preview.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
