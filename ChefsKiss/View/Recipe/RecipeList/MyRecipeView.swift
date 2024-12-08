//
//  MyRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 12/6/24.
//

import SwiftUI

struct MyRecipeView: View {
    /* Sort
     @State private var recipeType = "All"
     
     @State private var sortOrder = [
         SortDescriptor(\Recipe.title)
     ]
     */
    
    var body: some View {
        NavigationStack {
            Group {
//                if recipes.isEmpty {
//                    Button {
//                        isAddViewPresented.toggle()
//                    } label: {
//                        ContentUnavailableView("No Recipes", systemImage: "note.text.badge.plus", description: Text("Tap to add your first recipe."))
//                            .foregroundStyle(.accent)
//                    }
//                } else {
//                    MyRecipeListView()
//                        .toolbar {
//                            Menu {
//                                Button {
//                                    
//                                } label: {
//                                    
//                                }
//                            }
//                            
//            //                if !recipes.isEmpty {
//            //                    Menu("Filter/Sort", systemImage: "arrow.up.arrow.down") {
//            ////                        Picker("Filter/Sort", selection: <#T##Binding<Hashable>#>) {
//            ////
//            ////                        }
//            //                    }
//            //
//            //                }
//                            
//                            if !recipes.isEmpty {
//                                Button {
//                                    isAddViewPresented.toggle()
//                                } label: {
//                                    Image(systemName: "plus.circle.fill")
//                                        .scaleEffect(1.5)
//                                }
//                            }
//                            
//                        }
                }
        }
        
        /* Sort
         MyRecipeListView(type: recipeType, sortOrder: sortOrder)
             .tabItem {
                 Label("My Recipes", systemImage: "book.closed")
             }
         */
    }
    
    //    init(type: String = "All", sortOrder: [SortDescriptor<Recipe>]) {
    //        _recipes = Query(filter: #Predicate {
    //            if type == "All" {
    //                return true
    //            } else {
    //                return $0.type == type
    //            }
    //        }, sort: sortOrder)
    //    }
}

#Preview {
    MyRecipeView()
}
