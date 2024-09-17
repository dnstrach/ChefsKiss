//
//  KissAnimation.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/3/24.
//

import SwiftUI

struct KissAnimation: View {
    @State private var kissing = false

    var body: some View {
        ZStack {
            BackgroundView()
            KissView(kissing: $kissing)
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Color.white.edgesIgnoringSafeArea(.all)
    }
}

// will replace placeholder view
struct KissView: View {
    @Binding var kissing: Bool

    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            
           Image("Image")
                .resizable()
                .scaledToFill()
                    .frame(width: 600, height: 400)
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
                .offset(x: 110, y: -60)
                .rotationEffect(.degrees(90.0))
                .scaleEffect(kissing ? 1.5 : 1)
              //  .animation(Animation.spring(response: 0.5, dampingFraction: 0.5))
                .onAppear() {
                    withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.8).repeatForever().delay(0.5)) {
                        self.kissing.toggle()
                    }
                }
        }
    }
}

#Preview {
    KissAnimation()
}
