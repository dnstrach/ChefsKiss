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
    
    let recipe: MyRecipe?
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                dismiss()
            } label: {
                Text("Cancel")
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
                Text("Save")
            }
            .padding(.trailing)
        }
        .frame(height: 60)
    }
    
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
            let newRecipe = MyRecipe(
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
//        let previewer = try MyRecipePreview()
//
//        return NavigationBarView(viewModel: AddEditRecipeViewModel(), recipe: previewer.recipe)
//            .modelContainer(previewer.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
