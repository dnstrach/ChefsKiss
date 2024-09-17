//
//  APITitleView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APITitleView: View {
    let viewModel: APIRecipeDetailViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.remainingTitle(recipe: recipe))
                    .font(.system(size: 34, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APITitleView(viewModel: APIRecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
