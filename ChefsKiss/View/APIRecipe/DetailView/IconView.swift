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
          //  ZStack {
                HStack(spacing: 20) {
                    if recipe.isVegetarian {
                        iconAndLabel(imageName: "vegetarianIcon", label: "Vegetarian")
                    }
                    
                    if recipe.isVegan {
                        iconAndLabel(imageName: "veganIcon", label: "Vegan")
                    }
                    
                    if recipe.isDairyFree {
                        iconAndLabel(imageName: "dairyFreeIcon", label: "Dairy Free")
                    }
                    
                    if recipe.isGlutenFree {
                        iconAndLabel(imageName: "glutenFreeIcon", label: "Gluten Free")
                        
                    }
                }
          //  }
        }
        .contentMargins(10, for: .scrollContent)
    }
    
    private func iconAndLabel(imageName: String, label: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.accent)
               // .fill(LinearGradient(colors: [.accent, .accent3], startPoint: .top, endPoint: .bottom))
            
//                .stroke(Color.accent, lineWidth: 2)
//                .foregroundStyle(Color.clear)
            
            
            
            
              //  .foregroundStyle(Color.accent)
            
//                .fill(
//                    RadialGradient(gradient: Gradient(colors: [.accent, .accent1, .accent2]), center: .center, startRadius: 0, endRadius: 50)
//                )
//            
            HStack {
                Image(imageName)
                .resizable()
                .frame(width: 40, height: 40)
                
                Text(label)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
          //  .padding(.top, 5)
          //  .padding(.bottom, 5)
            .padding(.leading)
            .padding(.trailing)
           // .padding(.trailing)
        }
    }
    
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return IconView(recipe: preview.recipe, viewModel: APIRecipeDetailViewModel())
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
