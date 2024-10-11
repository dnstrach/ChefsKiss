//
//  Modifier.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/10/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .font(.title3)
            .foregroundStyle(Color.primary)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ScrollButton: ViewModifier {
    @Binding var isButtonShown: Bool
    var scrollProxy: ScrollViewProxy
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottomTrailing) {
                if isButtonShown {
                    Button {
                        withAnimation {
                            scrollProxy.scrollTo(1, anchor: .top)
                        }
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .opacity(0.2)
                            .scaleEffect(3)
                           // .offset(x: geo.size.width - 80 , y: geo.size.height - 80)
                            .frame(width: 80, height: 80)
                    }
                }
            }
    }
}

struct DetectScroll: ViewModifier {
    @Binding var isButtonShown: Bool
    var geoProxy: GeometryProxy
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { innerGeo in
                Color.clear
                    .onChange(of: innerGeo.frame(in: .global).minY) { _, newY in
                        let screenHeight = geoProxy.size.height
                        isButtonShown = newY < -(screenHeight / 4)
                    }
            })
    }
}
