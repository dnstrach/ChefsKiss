//
//  NavigationBarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 11/5/24.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    let recipe: Recipe?
    
    var body: some View {
    //    ZStack {
        //    Color.textfield.opacity(0.2)
            
//            Rectangle()
//                .fill(Color.textfield.opacity(0.2))
            
//            Color(Color.textfield.opacity(0.3))
            
            HStack(alignment: .center) {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.square.fill")
                        .foregroundStyle(.accent1)
                        .scaleEffect(1.5)
                }
                .padding(.leading)
                
                Spacer()
                
                Text(recipe == nil ? "Add Recipe" : "Edit Recipe")
                    .foregroundStyle(.accent1)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    withAnimation {
                        save()
                        dismiss()
                    }
                } label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .foregroundStyle(.accent1)
                        .scaleEffect(1.5)
                }
                .padding(.trailing)
            }
            .frame(height: 60)
        }
        
 //   }
    
    func save() {
        if let recipe {
            recipe.title = viewModel.title
            recipe.summary = viewModel.summary
            recipe.servings = viewModel.servings
            recipe.prepTime = viewModel.prepTime
            recipe.cookTime = viewModel.cookTime
            recipe.ingredients = viewModel.ingredients
            recipe.instructions = viewModel.instructions
            recipe.appliances = viewModel.appliances
            
            viewModel.saveImage(recipe)
        } else {
            let newRecipe = Recipe(
                title: viewModel.title,
                summary: viewModel.summary,
                servings: viewModel.servings,
                prepTime: viewModel.prepTime,
                cookTime: viewModel.cookTime,
                ingredients: viewModel.ingredients,
                steps: viewModel.instructions,
                appliances: viewModel.appliances
            )
            
            viewModel.saveImage(newRecipe)
            context.insert(newRecipe)
        }
    }
}

//#Preview {
//    do {
//        let previewer = try RecipePreview()
//
//        return NavigationBarView(viewModel: AddEditRecipeViewModel(), recipe: previewer.recipe)
//            .modelContainer(previewer.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
