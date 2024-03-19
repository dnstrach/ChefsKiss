//
//  EditRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import PhotosUI
import SwiftUI

struct EditRecipeView: View {
    // @ObservedObject var vm: RecipeViewModel
    @Bindable var recipe: Recipe
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        Form {
            Section {
                if let imageData = recipe.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a Photo", systemImage: "photo.badge.plus")
                }
            }
            
            Section {
                TextField("Name", text: $recipe.title)
                    .textContentType(.name)
                
                TextField("Instructions", text: $recipe.instructions, axis: .vertical)
            }
        }
        .navigationTitle("Edit Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedItem, loadPhoto)
    }
    
    func loadPhoto() {
        Task { @MainActor in
            recipe.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditRecipeView(recipe: previewer.recipe)
            .modelContainer(previewer.container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

