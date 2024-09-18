//
//  ImagePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/26/24.
//

import PhotosUI
import SwiftUI

struct ImagePickerView: View {
    let imageState: ImageState
    let recipe: Recipe?
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
      //  VStack {

        HStack {
            Spacer()
            
            switch viewModel.imageState {
            case .savedImage:
                Button {
                    if let recipe = recipe {
                        viewModel.clearPhoto(recipe: recipe)
                    }
                } label: {
                    Image(systemName: "x.circle")
                }
            case .success:
                Button {
                    if let recipe = recipe {
                        viewModel.clearPhoto(recipe: recipe)
                    } else {
                        viewModel.clearAddViewPhoto()
                    }
                } label: {
                    Image(systemName: "x.circle")
                }
            default:
                EmptyView()
            }
            
        }
            
            HStack {
                switch imageState {
                case .empty:
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import photo"))
                        .foregroundStyle(.accent)
                    
                case .loading:
                    ProgressView()
                   
                    // savedImage will show larger width/height because being shown from Data -> UIImage
                case .savedImage:
                    if let recipe = recipe {
                        if let savedImage = recipe.image,
                           let uiSavedImage = UIImage(data: savedImage) {
                            Image(uiImage: uiSavedImage)
                                .resizable()
                                .scaledToFit()
                        }
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
            .overlay {
                PhotosPicker(
                    "",
                    selection: $viewModel.selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                )
            }
       // }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return ImagePickerView(imageState: .empty, recipe: preview.recipe, viewModel: AddEditRecipeViewModel())
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
