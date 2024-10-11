//
//  RoundedRectangleView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/9/24.
//

import SwiftUI

struct RoundedRectangleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.background)
            .opacity(0.2)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.accent))
         //   .shadow(color: Color.shadow, radius: 5)
    }
}

#Preview {
    RoundedRectangleView()
}
