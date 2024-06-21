//
//  ImageContainerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/11/24.
//

import SwiftUI

struct ImageContainerView: View {
    let image: Image
    @State private var width: CGFloat = .zero
    
    var body: some View {
        GeometryReader { proxy in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: proxy.size.width, height: proxy.size.width * 0.75)
                .onAppear {
                    width = proxy.size.width
                }
        }
        // .frame(maxWidth: .infinity, maxHeight: 250)
        .clipped()
    }
}

//#Preview {
//    let image: Image
//    
//    ImageContainerView(image: image)
//}
