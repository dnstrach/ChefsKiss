//
//  APISummaryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APISummaryView: View {
    let recipe: APIRecipe   
    
    var body: some View {
        Text(recipe.summary.stringByStrippingHTMLTags())
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APISummaryView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
