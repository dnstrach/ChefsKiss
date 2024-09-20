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
        // ZStack  {
            KissView(kissing: $kissing)
       // }
    }
}

// will replace placeholder view
struct KissView: View {
    @Binding var kissing: Bool
    @State private var isRotating: Bool = true
    
    @State private var degrees: Double = 0

    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(
                    LinearGradient(colors: [.accent, .accent1, .accent2], startPoint: .top, endPoint: .bottom)
                )
               // .foregroundStyle(.accent)
                .frame(width: 125, height: 125)
                .rotationEffect(.degrees(degrees))
                .onAppear(perform: {
                    withAnimation(
                        .linear(duration: 200.0).repeatForever()) {
                            degrees += 36000
                    }
                })
            
           // VStack {
                Image("Loading")
                     .resizable()
                     .clipShape(Circle())
                     .scaledToFill()
                     .frame(width: 100, height: 50)
                 
                 Image(systemName: "heart.fill")
                     .resizable()
                     .frame(width: 30, height: 30)
                     .foregroundColor(.red)
                     .offset(x: 35, y: 35)
                     .scaleEffect(kissing ? 2 : 0.7)
                   //  .animation(Animation.spring(response: 0.5, dampingFraction: 0.5))
                     .onAppear() {
                         withAnimation(Animation.spring(response: 2.0, dampingFraction: 0.8).repeatForever().delay(0.2)) {
                             self.kissing.toggle()
                         }
                 //    }
                   //  .padding()

            }
        }
    }
}

#Preview {
    KissAnimation()
}
