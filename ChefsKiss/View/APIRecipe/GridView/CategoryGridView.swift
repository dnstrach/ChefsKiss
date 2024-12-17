//
//  CategoriesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftUI

struct CategoryGridView: View {
    let category: CategoryTitle
    let searchParam: CategoryParam
    let rows = [GridItem(.flexible(minimum: 100))]
  
    var body: some View {
        VStack(alignment: .leading) {
            Text(category.rawValue)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 20) {
                    switch searchParam {
                    case .cuisine:
                        ForEach(Cuisine.allCases, id: \.self) { cuisine in
                            NavigationLink {
                                RecipesView(viewModel: ExploreViewModel(searchTerm: .categoryParam(param: searchParam.rawValue, value: cuisine.rawValue)))
                            } label: {
                                CategoryLabel(category: cuisine.rawValue.capitalized)
                            }
                        }
                        
                    case .dishType:
                        ForEach(DishType.allCases, id: \.self) { dish in
                            NavigationLink {
                                RecipesView(viewModel: ExploreViewModel(searchTerm: .categoryParam(param: searchParam.rawValue, value: dish.rawValue)))
                            } label: {
                                CategoryLabel(category: dish.rawValue.capitalized)
                            }
                        }
                        
                    case .diet:
                        ForEach(Diet.allCases, id: \.self) { diet in
                            NavigationLink {
                                RecipesView(viewModel: ExploreViewModel(searchTerm: .categoryParam(param: searchParam.rawValue, value: diet.rawValue)))
                            } label: {
                                CategoryLabel(category: diet.rawValue)
                            }
                        }
                        
                    case .intolerance:
                        ForEach(Intolerance.allCases, id: \.self) { intolerance in
                            NavigationLink {
                                RecipesView(viewModel: ExploreViewModel(searchTerm: .categoryParam(param: searchParam.rawValue, value: intolerance.rawValue)))
                            } label: {
                                CategoryLabel(category: intolerance.rawValue.capitalized)
                            }
                        }
                    }
                }
            }
        }
        .padding(.leading)
        .padding(.bottom)
    }
}

struct CategoryLabel: View {
    var category: String
    
    var body: some View {
        VStack {
            Image(category.lowercased())
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.theme)
                        .shadow(
                            color: .gray.opacity(0.5),
                            radius: 10, x: 0, y: 0
                        )
                )
                .aspectRatio(contentMode: .fit)
            Text(category)
                .font(.title3)
                .foregroundStyle(Color.primary)
        }
    }
}

#Preview {
    ScrollView {
        Group {
            CategoryGridView(category: .cuisine, searchParam: .cuisine)
            CategoryGridView(category: .dishType, searchParam: .dishType)
            CategoryGridView(category: .diet, searchParam: .diet)
            CategoryGridView(category: .intolerance, searchParam: .intolerance)
        }
    }
}


