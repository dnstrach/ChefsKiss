//
//  EditRecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/10/24.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class EditRecipeViewModel: ObservableObject {
    @Published var imageState: ImageState = .empty
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            if let selectedImage {
                let progress = loadTransferrable(from: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    func clearPhoto() {
        imageState = .empty
    }
    
   private func loadTransferrable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
                // why self????
                guard selectedImage == self.selectedImage else { return }
                switch result {
                case .success(let image?):
                    self.imageState = .success(image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    func saveImage(_ recipe: Recipe) {
        guard let selectedImage else { return }
        
        Task {
            do {
                let data = try await selectedImage.loadTransferable(type: Data.self)
                
                guard let data, let uiImage = UIImage(data: data) else {
                    throw PhotoError.badConversion
                }
                
                if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                    recipe.image = imageData
                }

            } catch {
                print(error)
            }
        }
        
    }
}
