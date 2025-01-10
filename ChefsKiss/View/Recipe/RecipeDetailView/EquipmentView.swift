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
        ZStack {
            RoundedRectangleView()
            
            VStack(alignment: .leading) {
                Text("Equipment")
                    .subtitleFont()
                    .padding(.leading)
                    .padding(.top)
                
                if !recipe.sortedEquipment.isEmpty {
                    LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                        ForEach(recipe.sortedEquipment, id:\.id) { equipment in
                            HStack(spacing: 5) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.accent)
                                
                                Text(equipment.name)
                                    .contentFont()
                                    .frame(maxHeight: .infinity)
                                    .padding(.bottom, 5)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.leading)
                    
                } else {
                    HStack {
                        Text("No equipment listed")
                            .contentFont()
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
            }
            .padding(.bottom)
        }
        .padding()
        .padding(.horizontal, 20)
    }
}

//#Preview {
//    do {
//        let preview = try RecipePreview()
//
//        return EquipmentView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
//            .modelContainer(preview.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
