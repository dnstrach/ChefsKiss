//
//  ImagePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/1/24.
//

import SwiftUI

struct AddImagePickerView: View {
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
    Form {
        AddImagePickerView(imageState: .empty)
    }
}

