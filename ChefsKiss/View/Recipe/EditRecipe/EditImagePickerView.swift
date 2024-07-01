//
//  EditImagePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/2/24.
//

import SwiftUI

struct EditImagePickerView: View {
    let imageState: ImageState
    var recipe: Recipe
    
    var body: some View {
        switch imageState {
        case .empty:
            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import photo"))
                .foregroundStyle(.accent)
            
        case .loading:
            ProgressView()
           
            // savedImage will show larger width/height because being shown from Data -> UIImage
        case .savedImage:
            if let savedImage = recipe.image,
               let uiSavedImage = UIImage(data: savedImage) {
                Image(uiImage: uiSavedImage)
                    .resizable()
                    .scaledToFit()
            }
           
            // selected image will show smaller width/height because being shown as Image
        case .success(let data):
            if let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    do {
        let previewer = try RecipePreview()
        
        return Form {
            EditImagePickerView(imageState: .empty, recipe: previewer.recipe)
        }
        .modelContainer(previewer.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
