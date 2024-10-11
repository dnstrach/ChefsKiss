//
//  XButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/10/24.
//

import SwiftUI

struct XButtonView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    let imageState: ImageState
    let recipe: Recipe?
    
    var body: some View {
        Button {
            if let recipe = recipe {
                viewModel.clearPhoto(recipe: recipe)
            }
        } label: {
            Image(systemName: "x.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.accent)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        return XButtonView(viewModel: AddEditRecipeViewModel(), imageState: .empty, recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
