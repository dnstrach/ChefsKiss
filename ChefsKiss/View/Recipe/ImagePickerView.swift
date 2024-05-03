//
//  ImagePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/1/24.
//

import SwiftUI

struct ImagePickerView: View {
    let imageState: ImageState

    var body: some View {
        switch imageState {
        case .empty:
            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import photo"))
                .foregroundStyle(.accent)
            
        case .loading:
            ProgressView()
            
        case .savedImage:
            EmptyView()
            
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
    ImagePickerView(imageState: .empty)
}

//do {
//    let previewer = try Previewer()
//    
//    return ImagePickerView(imageState: .empty, recipe: previewer.recipe)
//        .modelContainer(previewer.container)
//} catch {
//    fatalError("Failed to create preview container.")
//}
