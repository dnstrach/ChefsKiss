//
//  LaunchAnimation.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 11/7/24.
//

import SwiftUI

struct LaunchAnimation: View {
    @State var kissing: Bool = true
    
    var body: some View {
        ZStack {
            Color.accent1
                .ignoresSafeArea(.all)
            
            Image("LaunchIcon")
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .offset(x: 40, y: 70)
                .scaleEffect(kissing ? 3 : 2)
                .onAppear() {
                    withAnimation(Animation.spring(response: 2.0, dampingFraction: 0.9).repeatForever().delay(0.2)) {
                        self.kissing.toggle()
                    }
                }
        }

    }
}

#Preview {
    LaunchAnimation()
}
