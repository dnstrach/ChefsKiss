//
//  ImagePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/26/24.
//

import PhotosUI
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var imageState: ImageState
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: CameraView
    
    init(picker: CameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.imageState = .cameraImage
        self.picker.dismiss()
    }
}

struct ImagePickerView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var showCamera: Bool = false
    
    let recipe: Recipe?
    
    var body: some View {
        VStack {
            HStack {
                CameraButtonView(cameraView: $showCamera)
                
                Spacer()
                
                switch viewModel.imageState {
                case .savedImage:
                    XButtonView(viewModel: viewModel, recipe: recipe, imageState: viewModel.imageState)
                case .cameraImage:
                    XButtonView(viewModel: viewModel, recipe: recipe, imageState: viewModel.imageState)
                case .success:
                    XButtonView(viewModel: viewModel, recipe: recipe, imageState: viewModel.imageState)
                default:
                    EmptyView()
                }
                
            }
            
            HStack {
                switch viewModel.imageState {
                case .empty:
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import photo"))
                        .foregroundStyle(.accent)
                    
                case .loading:
                    KissAnimation()
                    
                    // savedImage will show larger width/height because being shown from Data -> UIImage
                case .savedImage:
                    if let recipe = recipe {
                        if let savedImage = recipe.image, let uiImage = UIImage(data: savedImage) {
                            Image(uiImage: uiImage)
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
                            .padding()
                    }
                    
                case .cameraImage:
                    if let uiImage = viewModel.selectedCameraImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding()
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
                    selection: $viewModel.selectedPhoto,
                    matching: .images,
                    photoLibrary: .shared()
                )
            }
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(selectedImage: $viewModel.selectedCameraImage, imageState: $viewModel.imageState)
            }
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return ImagePickerView(viewModel: AddEditRecipeViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
