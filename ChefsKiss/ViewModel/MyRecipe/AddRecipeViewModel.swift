//
//  AddRecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/9/24.
//

import Foundation
import PhotosUI
import SwiftUI

enum PhotoError: Error {
    case badConversion
}

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case savedImage
    case failure(Error)
}

@MainActor
class AddRecipeViewModel: ObservableObject {
    @Published private(set) var imageState: ImageState = .empty

    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            if let selectedImage {
                let progress = loadTransferable(from: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    func clearPhoto() {
        imageState = .empty
    }
    
    private func loadTransferable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
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


