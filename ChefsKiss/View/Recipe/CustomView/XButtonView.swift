//
//  XButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/10/24.
//

import SwiftUI

struct XButtonView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    let recipe: Recipe?
    
    let imageState: ImageState
    
    var body: some View {
        Button {
            viewModel.clearPhoto(recipe: recipe)
        } label: {
            Image(systemName: "x.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.accent)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.top)
    }
}

//#Preview {
//    do {
//        let preview = try RecipePreview()
//        return XButtonView(viewModel: AddEditRecipeViewModel(), recipe: preview.recipe, imageState: .empty)
//            .modelContainer(preview.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
