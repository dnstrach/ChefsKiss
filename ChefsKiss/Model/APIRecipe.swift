//
//  APIRecipe.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

struct Response: Codable {
    var results: [APIRecipe]
}

struct APIRecipe: Codable {
    let id: Int
    let title: String
    let summary: String
    let image: String
    let imageType: String
    //// icons
//    let vegetarian: Bool
//    let vegan: Bool
//    let glutenFree: Bool
//    let dairyFree: Bool
//    let veryHealthy: Bool
//    let sustainable: Bool
   // //
    let readyInMinutes: Int
    let servings: Int
//    let sourceUrl: String
//    let cuisines: [String]?
//    let dishTypes: [String]?
//    let sideDish: [String]?
//    let diets: [String]?
    let analyzedInstructions: [Instruction]
    
//    static let dummyRecipe = APIRecipe(
//        id: 1,
//        title: "Sample Recipe",
//        summary: "This is a sample recipe summary",
//        image: "sample_image", imageType: "jpg",
////        vegetarian: true,
////        vegan: false,
////        glutenFree: true,
////        dairyFree: false,
////        veryHealthy: false,
////        sustainable: true,
//        readyInMinutes: 30,
//        servings: 4,
////        sourceUrl: "https://sampleurl.com",
////        cuisines: ["Italian"],
////        dishTypes: ["Main Course"],
//       // sideDish: nil, 
//        // diets: nil,
//        analyzedInstructions: [
//            Instruction(steps: [
//                Step(number: 1, step: "Step 1",
//                     ingredients: [
//                        Ingredient(id: 1,
//                                   name: "Ingredient 1"
//                                  // image: "ingredient_image"
//                                  )])])
//        ]
//    )
    
    static let dummyRecipes = [
        APIRecipe(
            id: 1,
            title: "Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https",
            imageType: "jpg",
//            vegetarian: true,
//            vegan: false,
//            glutenFree: true,
//            dairyFree: false,
//            veryHealthy: false,
//            sustainable: true,
            readyInMinutes: 30,
            servings: 4,
//            sourceUrl: "https://sampleurl.com",
//            cuisines: ["Italian"],
//            dishTypes: ["Main Course"],
           // sideDish: nil, diets: nil,
            analyzedInstructions: [
                Instruction(steps: [
                    Step(number: 1,
                         step: "Step 1",
                         ingredients: [
                            Ingredient(id: 1, 
                                       name: "Ingredient 1" //,
                                      // image: "ingredient_image"
                                      )])])
            ]
        ),
        
       APIRecipe(
            id: 2,
            title: "Sample Recipe Long Text Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https://spoonacular.com/recipeImages/794538-312x231.jpg",
            imageType: "jpg",
//            vegetarian: true,
//            vegan: false,
//            glutenFree: true,
//            dairyFree: false,
//            veryHealthy: false,
//            sustainable: true,
            readyInMinutes: 30,
            servings: 4,
//            sourceUrl: "https://sampleurl.com",
//            cuisines: ["Italian"],
//            dishTypes: ["Main Course"],
           // sideDish: nil, diets: nil,
            analyzedInstructions: [
                Instruction(steps: [
                    Step(number: 1,
                         step: "Step 1",
                         ingredients: [
                            Ingredient(id: 1,
                                       name: "Ingredient 1" //,
                                      // image: "ingredient_image"
                                      )])])
            ]
        ),
        
        APIRecipe(
             id: 3,
             title: "Sample Recipe Long Text Sample Recipe",
             summary: "This is a sample recipe summary",
             image: "https://spoonacular.com/recipeImages/794538-312x231.jpg",
             imageType: "jpg",
//             vegetarian: true,
//             vegan: false,
//             glutenFree: true,
//             dairyFree: false,
//             veryHealthy: false,
//             sustainable: true,
             readyInMinutes: 30,
             servings: 4,
//             sourceUrl: "https://sampleurl.com",
//             cuisines: ["Italian"],
//             dishTypes: ["Main Course"],
           //  sideDish: nil, diets: nil,
             analyzedInstructions: [
                 Instruction(steps: [
                    Step(number: 1,
                         step: "Step 1",
                         ingredients: [
                            Ingredient(id: 1,
                                       name: "Ingredient 1" //,
                                      // image: "ingredient_image"
                                      )])])
             ]
         ),
        
        APIRecipe(
            id: 4,
            title: "Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https://spoonacular.com/recipeImages/794538-312x231.jpg",
            imageType: "jpg",
//            vegetarian: true,
//            vegan: false,
//            glutenFree: true,
//            dairyFree: false,
//            veryHealthy: false,
//            sustainable: true,
            readyInMinutes: 30,
            servings: 4,
//            sourceUrl: "https://sampleurl.com",
//            cuisines: ["Italian"],
//            dishTypes: ["Main Course"],
          //  sideDish: nil, diets: nil,
            analyzedInstructions: [
                Instruction(steps: [
                    Step(number: 1,
                         step: "Step 1",
                         ingredients: [
                            Ingredient(id: 1,
                                       name: "Ingredient 1"//,
                                      // image: "ingredient_image"
                                      )])])
            ]
        )
    ]
}

struct Instruction: Codable {
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let id: Int
    let name: String
   // let image: String
}

/*
 {
            "vegetarian": false,
            "vegan": false,
            "glutenFree": true,
            "dairyFree": true,
            "veryHealthy": false,
            "cheap": false,
            "veryPopular": true,
            "sustainable": false,
            "lowFodmap": false,
            "weightWatcherSmartPoints": 6,
            "gaps": "no",
            "preparationMinutes": 10,
            "cookingMinutes": 120,
            "aggregateLikes": 32767,
            "healthScore": 33,
            "creditsText": "pinkwhen.com",
            "sourceName": "pinkwhen.com",
            "pricePerServing": 206.6,
            "id": 715424,
            "title": "The Best Chili",
            "readyInMinutes": 130,
            "servings": 8,
            "sourceUrl": "http://www.pinkwhen.com/the-best-chili-recipe/",
            "image": "https://spoonacular.com/recipeImages/715424-312x231.jpg",
            "imageType": "jpg",
            "summary": "Need a <b>gluten free and dairy free main course</b>? The Best Chili could be an excellent recipe to try. This recipe makes 8 servings with <b>326 calories</b>, <b>33g of protein</b>, and <b>7g of fat</b> each. For <b>$2.07 per serving</b>, this recipe <b>covers 29%</b> of your daily requirements of vitamins and minerals. This recipe from Pink When has 32767 fans. <b>The Super Bowl</b> will be even more special with this recipe. From preparation to the plate, this recipe takes roughly <b>2 hours and 10 minutes</b>. This recipe is typical of American cuisine. If you have tomato paste, oregano, cumin, and a few other ingredients on hand, you can make it. All things considered, we decided this recipe <b>deserves a spoonacular score of 96%</b>. This score is excellent. If you like this recipe, take a look at these similar recipes: <a href=\"https://spoonacular.com/recipes/5th-annual-chili-contest-entry-chili-con-carne-y-frijoles-618022\">5th Annual Chili Contest: Entry – Chili Con Carne y Frijoles</a>, <a href=\"https://spoonacular.com/recipes/5th-annual-chili-contest-entry-chili-mac-weekly-menu-1215721\">5th Annual Chili Contest: Entry – Chili Mac + Weekly Menu</a>, and <a href=\"https://spoonacular.com/recipes/10th-annual-chili-contest-entry-weeknight-white-chicken-chili-1145314\">10th Annual Chili Contest: Entry – Weeknight White Chicken Chili</a>.",
            "cuisines": [
                "American"
            ],
            "dishTypes": [
                "lunch",
                "soup",
                "main course",
                "main dish",
                "dinner"
            ],
            "diets": [
                "gluten free",
                "dairy free"
            ],
            "occasions": [
                "super bowl"
            ],
            "analyzedInstructions": [
                {
                    "name": "",
                    "steps": [
                        {
                            "number": 1,
                            "step": "Brown the lean ground beef in a deep skillet. Cook over medium heat until cooked all the way through, and then drain.In a large pan over high heat add in all of your additional ingredients: cooked ground beef, tomato juice, kidney beans, pinto beans, water, tomato paste, chili powder, cumin, black pepper, oregano, sugar, cayenne pepper, bell pepper, and chopped onions.Bring to a boil.Once your large pot of chili has started to boil, lower the heat and simmer for 2 hours uncovered.",
                            "ingredients": [
                                {
                                    "id": 23557,
                                    "name": "lean ground beef",
                                    "localizedName": "lean ground beef",
                                    "image": "fresh-ground-beef.jpg"
                                },
                                {
                                    "id": 2031,
                                    "name": "cayenne pepper",
                                    "localizedName": "cayenne pepper",
                                    "image": "chili-powder.jpg"
                                },
                                {
                                    "id": 1002030,
                                    "name": "black pepper",
                                    "localizedName": "black pepper",
                                    "image": "pepper.jpg"
                                },
                                {
                                    "id": 2009,
                                    "name": "chili powder",
                                    "localizedName": "chili powder",
                                    "image": "chili-powder.jpg"
                                },
                                {
                                    "id": 16033,
                                    "name": "kidney beans",
                                    "localizedName": "kidney beans",
                                    "image": "kidney-beans.jpg"
                                },
                                {
                                    "id": 11886,
                                    "name": "tomato juice",
                                    "localizedName": "tomato juice",
                                    "image": "tomato-juice.jpg"
                                },
                                {
                                    "id": 11887,
                                    "name": "tomato paste",
                                    "localizedName": "tomato paste",
                                    "image": "tomato-paste.jpg"
                                },
                                {
                                    "id": 10211821,
                                    "name": "bell pepper",
                                    "localizedName": "bell pepper",
                                    "image": "bell-pepper-orange.png"
                                },
                                {
                                    "id": 10023572,
                                    "name": "ground beef",
                                    "localizedName": "ground beef",
                                    "image": "fresh-ground-beef.jpg"
                                },
                                {
                                    "id": 16043,
                                    "name": "pinto beans",
                                    "localizedName": "pinto beans",
                                    "image": "pinto-beans.jpg"
                                },
                                {
                                    "id": 2027,
                                    "name": "oregano",
                                    "localizedName": "oregano",
                                    "image": "oregano.jpg"
                                },
                                {
                                    "id": 11282,
                                    "name": "onion",
                                    "localizedName": "onion",
                                    "image": "brown-onion.png"
                                },
                                {
                                    "id": 11819,
                                    "name": "chili pepper",
                                    "localizedName": "chili pepper",
                                    "image": "red-chili.jpg"
                                },
                                {
                                    "id": 1002014,
                                    "name": "cumin",
                                    "localizedName": "cumin",
                                    "image": "ground-cumin.jpg"
                                },
                                {
                                    "id": 19335,
                                    "name": "sugar",
                                    "localizedName": "sugar",
                                    "image": "sugar-in-bowl.png"
                                },
                                {
                                    "id": 14412,
                                    "name": "water",
                                    "localizedName": "water",
                                    "image": "water.png"
                                }
                            ],
                            "equipment": [
                                {
                                    "id": 404645,
                                    "name": "frying pan",
                                    "localizedName": "frying pan",
                                    "image": "pan.png"
                                },
                                {
                                    "id": 404752,
                                    "name": "pot",
                                    "localizedName": "pot",
                                    "image": "stock-pot.jpg"
                                }
                            ],
                            "length": {
                                "number": 120,
                                "unit": "minutes"
                            }
                        }
                    ]
                }
            ],
            "spoonacularScore": 96.3321304321289,
            "spoonacularSourceUrl": "https://spoonacular.com/the-best-chili-715424"
        }
 */

/*
// last recipe in Vietnamese
{"vegetarian":false,
    "vegan":false,
    "glutenFree":false,
    "dairyFree":true,
    "veryHealthy":false,
    "cheap":false,
    "veryPopular":false,
    "sustainable":false,
    "lowFodmap":false,
    "weightWatcherSmartPoints":2,
    "gaps":"no","preparationMinutes":-1,
    "cookingMinutes":-1,"aggregateLikes":1,
    "healthScore":7,
    "creditsText":"Foodista.com – The Cooking Encyclopedia Everyone Can Edit","license":"CC BY 3.0",
    "sourceName":"Foodista",
    "pricePerServing":91.11,
    "id":655903,
    "title":"Phyllo Dough Baked Spring Rolls",
    "readyInMinutes":45,
    "servings":20,
    "sourceUrl":"http://www.foodista.com/recipe/GQKBTPYV/phyllo-dough-baked-spring-rolls",
    "image":"https://spoonacular.com/recipeImages/655903-312x231.jpg",
    "imageType":"jpg",
    "summary":"If you want to add more <b>Vietnamese</b> recipes to your collection, Phyllo Dough Baked Spring Rolls might be a recipe you should try. This recipe serves 20 and costs 91 cents per serving. Watching your figure? This dairy free and pescatarian recipe has <b>92 calories</b>, <b>4g of protein</b>, and <b>2g of fat</b> per serving. This recipe is liked by 1 foodies and cooks. It is brought to you by Foodista. It will be a hit at your <b>Spring</b> event. It works best as a hor d'oeuvre, and is done in approximately <b>45 minutes</b>. A mixture of chili, approx. bean sprouts, sugar, and a handful of other ingredients are all it takes to make this recipe so yummy. All things considered, we decided this recipe <b>deserves a spoonacular score of 45%</b>. This score is solid. <a href=\"https://spoonacular.com/recipes/baked-brie-with-phyllo-dough-and-jam-594914\">Baked Brie with Phyllo Dough and Jam</a>, <a href=\"https://spoonacular.com/recipes/baked-spring-rolls-383610\">Baked Spring Rolls</a>, and <a href=\"https://spoonacular.com/recipes/baked-spring-rolls-9949\">Baked Spring Rolls</a> are very similar to this recipe.",
    "cuisines":["Vietnamese","Asian"],
    "dishTypes":["fingerfood","antipasti","starter","snack","appetizer","antipasto","hor d'oeuvre"],
    "diets":["dairy free","pescatarian"],
    "occasions":["spring","easter"],
    "analyzedInstructions":[
        {"name":"",
            "steps":[
                {"number":1,
                    "step":"Place 2 Tbsp. oil in a wok or large frying pan over medium to high heat.","ingredients":[{"id":4582,"name":"cooking oil","localizedName":"cooking oil","image":"vegetable-oil.jpg"}],"equipment":[{"id":404645,"name":"frying pan","localizedName":"frying pan","image":"pan.png"},{"id":404666,"name":"wok","localizedName":"wok","image":"wok.png"}]}]},{"name":"Add garlic, galangal (or ginger), shallots, and chilli. Stir-fry until fragrant (about 1 minute). Stir-frying Tip","steps":[{"number":1,"step":"Add a little water to the wok/pan when it gets too dry instead of more oil.","ingredients":[{"id":14412,"name":"water","localizedName":"water","image":"water.png"},{"id":4582,"name":"cooking oil","localizedName":"cooking oil","image":"vegetable-oil.jpg"}],"equipment":[{"id":404645,"name":"frying pan","localizedName":"frying pan","image":"pan.png"},{"id":404666,"name":"wok","localizedName":"wok","image":"wok.png"}]},{"number":2,"step":"Add cabbage, mushrooms, and tofu and shrimp. As you stir-fry, add the sauce.Stir-fry 1-2 minutes, add the rest of the vegetables, except for the bean sprouts, coriander and basil.Stir-fry until vegetables have softened.","ingredients":[{"id":11043,"name":"bean sprouts","localizedName":"bean sprouts","image":"bean-sprouts.jpg"},{"id":11583,"name":"vegetable","localizedName":"vegetable","image":"mixed-vegetables.png"},{"id":1012013,"name":"coriander","localizedName":"coriander","image":"ground-coriander.jpg"},{"id":11260,"name":"mushrooms","localizedName":"mushrooms","image":"mushrooms.png"},{"id":11109,"name":"cabbage","localizedName":"cabbage","image":"cabbage.jpg"},{"id":15270,"name":"shrimp","localizedName":"shrimp","image":"shrimp.png"},{"id":2044,"name":"basil","localizedName":"basil","image":"basil.jpg"},{"id":0,"name":"sauce","localizedName":"sauce","image":""},{"id":16213,"name":"tofu","localizedName":"tofu","image":"tofu.png"}],"equipment":[],"length":{"number":2,"unit":"minutes"}}]},{"name":"Remove from heat and add bean sprouts, tossing to mix in.Do a taste test for salt, adding 1 Tbsp. more fish or soy sauce if not salty enough.ASSEMBLING THE ROLLSPaint half of 1 sheet of phyllo dough with melted butter, margarine, or olive oil.Using the butter as glue, fold the sheet in half to form a rectangle.Pile about 1/3 cup of filling at the bottom of a narrow side, leaving a 2-inch border on 3 sides.To form the log, fold the bottom flap up and over the filling, fold in the sides and roll up to seal.Paint the roll with melted butter and place, seam side down, onto a baking sheet.Repeat with the remaining sheets of phyllo dough.Tips","steps":[{"number":1,"step":"Spread the filling lengthwise along the phyllo dough nearer the end closest to you. Also, try not to include too much of the liquid left in the bottom of your wok/pan (a slotted spoon works well for this  drier filling is better. Now sprinkle some of the fresh coriander and basil over the filling.BAKING THE ROLLSPreheat the oven to 40","ingredients":[{"id":11165,"name":"fresh cilantro","localizedName":"fresh cilantro","image":"cilantro.png"},{"id":18338,"name":"filo pastry","localizedName":"filo pastry","image":"filo-dough.png"},{"id":0,"name":"spread","localizedName":"spread","image":""},{"id":2044,"name":"basil","localizedName":"basil","image":"basil.jpg"}],"equipment":[{"id":404636,"name":"slotted spoon","localizedName":"slotted spoon","image":"slotted-spoon.jpg"},{"id":404784,"name":"oven","localizedName":"oven","image":"oven.jpg"},{"id":404645,"name":"frying pan","localizedName":"frying pan","image":"pan.png"},{"id":404666,"name":"wok","localizedName":"wok","image":"wok.png"}]},{"number":2,"step":"Bake in the center of the oven for 15 to 20 minutes, until lightly golden all over.","ingredients":[],"equipment":[{"id":404784,"name":"oven","localizedName":"oven","image":"oven.jpg"}
*/
