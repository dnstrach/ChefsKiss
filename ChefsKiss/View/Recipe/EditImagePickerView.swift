//
//  EditImagePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/2/24.
//

import SwiftUI

struct EditImagePickerView: View {
    let imageState: ImageState
    let recipe: Recipe
    
    var body: some View {
        switch imageState {
        case .empty:
            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import photo"))
                .foregroundStyle(.accent)
            
        case .loading:
            ProgressView()
            
        case .savedImage:
            if let savedImage = recipe.image,
               let uiSavedImage = UIImage(data: savedImage) {
                Image(uiImage: uiSavedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
        case .success(let image):
            VStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 250)
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
        let previewer = try Previewer()
    
        return EditImagePickerView(imageState: .empty, recipe: previewer.recipe)
            .modelContainer(previewer.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
