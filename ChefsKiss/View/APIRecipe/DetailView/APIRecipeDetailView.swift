//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

//struct ScrollButton: ViewModifier {
//    @Binding var isButtonShown: Bool
//    var scrollProxy: ScrollViewProxy
//
//    func body(content: Content) -> some View {
//        content
//            .overlay(alignment: .bottomTrailing) {
//                if isButtonShown {
//                    Button {
//                        scrollProxy.scrollTo(1, anchor: .top)
//                    } label: {
//                        Image(systemName: "arrow.up.circle.fill")
//                            .opacity(0.2)
//                            .scaleEffect(3)
//                           // .offset(x: geo.size.width - 80 , y: geo.size.height - 80)
//                            .frame(width: 80, height: 80)
//                    }
//                }
//            }
//    }
//}
//
//struct DetectScroll: ViewModifier {
//    @Binding var isButtonShown: Bool
//    var geoProxy: GeometryProxy
//
//    func body(content: Content) -> some View {
//        content
//            .background(GeometryReader { innerGeo in
//                Color.clear
//                    .onChange(of: innerGeo.frame(in: .global).minY) { _, newY in
//                        let screenHeight = geoProxy.size.height
//                        isButtonShown = newY < -(screenHeight / 4)
//                    }
//            })
//    }
//}

struct APIRecipeDetailView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var savedRecipesViewModel: SavedRecipesViewModel
    //   @Query var savedRecipes: [APIRecipe]
    
    @StateObject var viewModel = APIRecipeDetailViewModel()
    
    
    @State private var showScrollToTopButton = false
    
    let recipe: APIRecipe
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                GeometryReader { geo in
                    ScrollView {
                        LazyVStack {
                            APITitleView(viewModel: viewModel, recipe: recipe)
                            
                            IconView(recipe: recipe, viewModel: viewModel)
                            
                            APIServingsDurationView(recipe: recipe)
                            
                            APISummaryView(recipe: recipe)
                            
                            APIIngredientsView(viewModel: viewModel, recipe: recipe)
                            
                            APIEquipmentView(viewModel: viewModel, recipe: recipe)
                            
                            APIInstructionsView(recipe: recipe)
                            
                            LinkButtonView(recipe: recipe)
                        }
                        .safeAreaInset(edge: .top) {
                            APIImageView(recipe: recipe)
                                .overlay(alignment: .topLeading) {
                                    BackButtonView()
                                }
                                .id(1)
                        }
                        .ignoresSafeArea(.all, edges: .all)
                        .modifier(DetectScroll(isButtonShown: $showScrollToTopButton, geoProxy: geo))
                    }
                    .modifier(ScrollButton(isButtonShown: $showScrollToTopButton, scrollProxy: value))
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .toolbar(.hidden, for: .navigationBar)
            .statusBarHidden(true)
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APIRecipeDetailView(recipe: preview.recipe)
            .modelContainer(preview.container)
            .environmentObject(SavedRecipesViewModel())
    } catch {
        fatalError("Failed to create preview container.")
    }
}


