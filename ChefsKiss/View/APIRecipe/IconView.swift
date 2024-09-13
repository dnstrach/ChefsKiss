//
//  IconView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/12/24.
//

import SwiftUI

struct IconView: View {
    let recipe: APIRecipe
    
    let viewModel: APIRecipeDetailViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                iconAndLabel(imageName: "vegetarianIcon", label: "Vegetarian")
                iconAndLabel(imageName: "veganIcon", label: "Vegan")
                iconAndLabel(imageName: "dairyFreeIcon", label: "Dairy Free")
                iconAndLabel(imageName: "glutenFreeIcon", label: "Gluten Free")
            }
        }
        .contentMargins(10, for: .scrollContent)
    }
    
    private func iconAndLabel(imageName: String, label: String) -> some View {
        HStack {
            Image(imageName)
            .resizable()
            .frame(width: 40, height: 40)
            
            Text(label)
        }
        .padding(.trailing)
    }
    
}

#Preview {
    
    IconView(recipe: APIRecipe.dummyRecipes[1], viewModel: APIRecipeDetailViewModel())
}

