//
//  Categories.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

enum CategoryTitle: String {
    case cuisine = "Cuisines"
    case dishType = "Dish Types"
    case diet = "Diets"
    case intolerance = "Intolerances"
}

enum CategoryParam: String, CaseIterable {
    case cuisine = "cuisine"
    case dishType = "type"
    case diet = "diet"
    case intolerance = "intolerances"
}

enum Cuisine: String, CaseIterable {
    case african
    case american
    case asian
    case british
    case cajun
    case caribbean
    case chinese
    case easternEurope = "eastern european"
    case european
    case french
    case german
    case greek
    case indian
    case irish
    case italian
    case japanese
    case jewish
    case korean
    case latinAmerican = "latin american"
    case mediterranean
    case mexican
    case middleEastern = "middle eastern"
    case nordic
    case southern
    case spanish
    case thai
    case vietnamese
}

enum DishType: String, CaseIterable {
    case appetizer
    case beverage
    case bread
    case breakfast
    case dessert
    case dinner
    case drink
    case fingerfood
    case mainCourse = "main course"
    case marinade
    case sauce
    case sideDish = "side dish"
    case snack
    case soup
}

enum Diet: String, CaseIterable {
    // defined raw values for all cases because unique case - Low FODMAP title - can't use .capitalized
    case glutenFree = "Gluten Free"
    case ketogenic = "Ketogenic"
    case lactoVegetarian = "Lacto-Vegetarian"
    case lowFodMap = "Low FODMAP"
    case ovoVegetarian = "Ovo-Vegetarian"
    case paleo = "Paleo"
    case pescetarian = "Pescetarian"
    case primal = "Primal"
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case whole30 = "Whole30"
}

enum Intolerance: String, CaseIterable {
    case dairy
    case egg
    case gluten
    case grain
    case peanut
    case seafood
    case sesame
    case shellfish
    case soy
    case sulfite
    case treeNut = "tree nut"
    case wheat
}
