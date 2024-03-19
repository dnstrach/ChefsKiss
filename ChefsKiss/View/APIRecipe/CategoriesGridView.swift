//
//  CategoriesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftUI

struct CategoriesGridView: View {
    let category: String
    let searchParam: Category
    
    let rows = [
        GridItem(.flexible(minimum: 100))
    ]
  
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 20) {
                    switch searchParam {
                    case .cuisine:
                        ForEach(Cuisine.allCases, id: \.self) { cuisine in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: SearchTerm(searchParam: searchParam.rawValue, searchValue: cuisine.rawValue)))
                            } label: {
                                CategoryLabel(category: cuisine.rawValue.capitalized)
                            }
                        }
                        
                    case .dishType:
                        ForEach(DishType.allCases, id: \.self) { dish in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: SearchTerm(searchParam: searchParam.rawValue, searchValue: dish.rawValue)))
                            } label: {
                                CategoryLabel(category: dish.rawValue.capitalized)
                            }
                        }
                        
                    case .diet:
                        ForEach(Diet.allCases, id: \.self) { diet in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: SearchTerm(searchParam: searchParam.rawValue, searchValue: diet.rawValue)))
                            } label: {
                                CategoryLabel(category: diet.rawValue.capitalized)
                            }
                        }
                        
                    case .intolerance:
                        ForEach(Intolerance.allCases, id: \.self) { intolerance in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: SearchTerm(searchParam: searchParam.rawValue, searchValue: intolerance.rawValue)))
                            } label: {
                                CategoryLabel(category: intolerance.rawValue.capitalized)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct CategoryLabel: View {
    var category: String

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image(category.lowercased())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary))
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            Text(category)
        }
    }
}

#Preview {
    ScrollView {
        Group {
            CategoriesGridView(category: "Cuisines", searchParam: .cuisine)
            CategoriesGridView(category: "Dish Types", searchParam: .dishType)
            CategoriesGridView(category: "Diets", searchParam: .diet)
            CategoriesGridView(category: "Intolerances", searchParam: .intolerance)
        }
        .previewLayout(.sizeThatFits)
    }
}
