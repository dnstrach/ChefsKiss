//
//  LineDividerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/9/24.
//

import SwiftUI

struct LineDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(Color.accent)
            .opacity(0.4)
            .padding(.horizontal)
            .padding(.horizontal)
    }
}

#Preview {
    LineDividerView()
}
