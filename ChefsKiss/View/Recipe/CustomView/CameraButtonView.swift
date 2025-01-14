//
//  CameraButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/10/24.
//

import SwiftUI

struct CameraButtonView: View {
    @Binding var cameraView: Bool
    
    var body: some View {
        Button {
            cameraView.toggle()
        } label: {
            Image(systemName: "camera.fill")
                .imageScale(.large)
                .foregroundStyle(.accent)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.top)
    }
}

#Preview {
    CameraButtonView(cameraView: .constant(false))
}
