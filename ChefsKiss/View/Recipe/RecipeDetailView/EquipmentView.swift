//
//  EquipmentView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct EquipmentView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Equipment")
                .font(.title2)
                .padding(.leading)
            
            LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                ForEach(recipe.sortedEquipment, id:\.id) { equipment in
                    Text(equipment.name)
                        .frame(maxHeight: .infinity)
                        .padding(.leading)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return EquipmentView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
