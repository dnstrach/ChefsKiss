//
//  Modifier.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/10/24.
//

import Combine
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

struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontDesign(.rounded)
            .fontWeight(.bold)
    }
}

struct ContentText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontDesign(.rounded)
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
                        withAnimation(.easeIn) {
                            scrollProxy.scrollTo(1, anchor: .top)
                        }
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .opacity(0.2)
                            .scaleEffect(3)
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

struct SheetTextfield: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.accent1))
    }
}

struct SheetBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .presentationDetents([.fraction(0.25)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(
                LinearGradient(colors: [.accent, .accent1.opacity(0.9), .accent2.opacity(0.9), .accent3.opacity(0.9), .accent2.opacity(0.9), .accent1.opacity(0.9), .accent], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
    }
}

extension View {
    func titleFont() -> some View {
        modifier(Title())
    }
    
    func subtitleFont() -> some View {
        modifier(Subtitle())
    }
    
    func contentFont() -> some View {
        modifier(ContentText())
    }
    
    func scrollButton(_ showButton: Binding<Bool>, scrollProxy: ScrollViewProxy) -> some View {
        modifier(ScrollButton(isButtonShown: showButton, scrollProxy: scrollProxy))
    }
    
    func showScrollButton(_ isButtonShown: Binding<Bool>, geoProxy: GeometryProxy) -> some View {
        modifier(DetectScroll(isButtonShown: isButtonShown, geoProxy: geoProxy))
    }
    
    func textfieldStyle() -> some View {
        modifier(SheetTextfield())
    }
    
    func sheetBackground() -> some View {
        modifier(SheetBackground())
    }
}
