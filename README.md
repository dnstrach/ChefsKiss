# [ChefsKiss](https://apps.apple.com/us/app/chefskiss/id6738972491)
ChefsKiss is a mobile recipe app built for users who love to cook! Key features include exploring 365,000+ recipes, saving favorite recipes, and creating a personal cookbook. Check out my [portfolio](https://dominiquestrachan.squarespace.com) to see features.

# REST API
The [Spoonacular API](https://spoonacular.com/food-api/docs#Search-Recipes-Complex) is integrated with ChefsKiss to show recipes by categories or search a recipe by its query. To decode the API response, the APIRecipe model is separated by Response and APIRecipe classes since the JSON object contains a nested object. 

### JSON Response from receipe Italian category showing first recipe object in results object
(https://api.spoonacular.com/recipes/complexSearch?apiKey=cce86962d1e94f68b85f3fad930d6ee6&addRecipeInformation=true&addRecipeInstructions=true&number=100&cuisine=italian)
```
{
    "results": [
        {
            "id": 715769,
            "image": "https://img.spoonacular.com/recipes/715769-312x231.jpg",
            "imageType": "jpg",
            "title": "Broccolini Quinoa Pilaf",
            "readyInMinutes": 30,
            "servings": 2,
            "sourceUrl": "https://pickfreshfoods.com/broccolini-quinoa-pilaf/",
            "vegetarian": true,
            "vegan": true,
            "glutenFree": true,
            "dairyFree": true,
            "veryHealthy": true,
            "cheap": false,
            "veryPopular": false,
            "sustainable": false,
            "lowFodmap": false,
            "weightWatcherSmartPoints": 17,
            "gaps": "no",
            "preparationMinutes": null,
            "cookingMinutes": null,
            "aggregateLikes": 94,
            "healthScore": 74.0,
            "creditsText": "pickfreshfoods.com",
            "license": null,
            "sourceName": "pickfreshfoods.com",
            "pricePerServing": 414.24,
            "summary": "Broccolini Quinoa Pilaf requires approximately <b>30 minutes</b> from start to finish. For <b>$4.14 per serving</b>, you get a main course that serves 2. One portion of this dish contains around <b>20g of protein</b> <b>31g of fat</b>, and a total of <b>625 calories</b>. Head to the store and pick up vegetable broth, onion, olive oil, and a few other things to make it today. A few people made this recipe, and 94 would say it hit the spot. It is a <b>rather expensive</b> recipe for fans of Mediterranean food. It is a good option if you're following a <b>gluten free, dairy free, lacto ovo vegetarian, and vegan</b> diet. It is brought to you by Pick Fresh Foods. With a spoonacular <b>score of 98%</b>, this dish is excellent. Similar recipes are <a href=\"https://spoonacular.com/recipes/spring-broccolini-kale-quinoa-bowls-734866\">Spring Broccolini & Kale Quinoa Bowls</a>, <a href=\"https://spoonacular.com/recipes/orange-sesame-salmon-with-quinoa-broccolini-839832\">Orange-Sesame Salmon with Quinoa & Broccolini</a>, and <a href=\"https://spoonacular.com/recipes/black-pepper-goat-cheese-and-chard-quinoa-with-roasted-broccolini-625829\">Black Pepper Goat Cheese and Chard Quinoa with Roasted Broccolini</a>.",
            "cuisines": [
                "Mediterranean",
                "Italian",
                "European"
            ],
            "dishTypes": [
                "side dish",
                "lunch",
                "main course",
                "main dish",
                "dinner"
            ],
            "diets": [
                "gluten free",
                "dairy free",
                "lacto ovo vegetarian",
                "vegan"
            ],
            "occasions": [],
            "analyzedInstructions": [
                {
                    "name": "",
                    "steps": [
                        {
                            "number": 1,
                            "step": "In a large pan with lid heat olive oil over medium high heat.",
                            "ingredients": [
                                {
                                    "id": 4053,
                                    "name": "olive oil",
                                    "localizedName": "olive oil",
                                    "image": "olive-oil.jpg"
                                }
                            ],
                            "equipment": [
                                {
                                    "id": 404645,
                                    "name": "frying pan",
                                    "localizedName": "frying pan",
                                    "image": "https://spoonacular.com/cdn/equipment_100x100/pan.png"
                                }
                            ]
                        },
                        {
                            "number": 2,
                            "step": "Add onions and cook for 1 minute.",
                            "ingredients": [
                                {
                                    "id": 11282,
                                    "name": "onion",
                                    "localizedName": "onion",
                                    "image": "brown-onion.png"
                                }
                            ],
                            "equipment": [],
                            "length": {
                                "number": 1,
                                "unit": "minutes"
                            }
                        },
                        {
                            "number": 3,
                            "step": "Add garlic and cook until onions are translucent and garlic is fragrant.",
                            "ingredients": [
                                {
                                    "id": 11215,
                                    "name": "garlic",
                                    "localizedName": "garlic",
                                    "image": "garlic.png"
                                },
                                {
                                    "id": 11282,
                                    "name": "onion",
                                    "localizedName": "onion",
                                    "image": "brown-onion.png"
                                }
                            ],
                            "equipment": []
                        },
                        {
                            "number": 4,
                            "step": "Add quinoa to pan, stir to combine. Slowly add in broth and bring to a boil.Cover and reduce heat to low, cook for 15 minutes.In the last 2-3 minutes of cooking add in broccolini on top of the quinoa (do not stir) and cover.Uncover and toss broccolini and quinoa together.Season to taste with salt and pepper.",
                            "ingredients": [
                                {
                                    "id": 1102047,
                                    "name": "salt and pepper",
                                    "localizedName": "salt and pepper",
                                    "image": "salt-and-pepper.jpg"
                                },
                                {
                                    "id": 98840,
                                    "name": "broccolini",
                                    "localizedName": "broccolini",
                                    "image": "broccolini.jpg"
                                },
                                {
                                    "id": 20035,
                                    "name": "quinoa",
                                    "localizedName": "quinoa",
                                    "image": "uncooked-quinoa.png"
                                },
                                {
                                    "id": 1006615,
                                    "name": "broth",
                                    "localizedName": "broth",
                                    "image": "chicken-broth.png"
                                }
                            ],
                            "equipment": [
                                {
                                    "id": 404645,
                                    "name": "frying pan",
                                    "localizedName": "frying pan",
                                    "image": "https://spoonacular.com/cdn/equipment_100x100/pan.png"
                                }
                            ],
                            "length": {
                                "number": 18,
                                "unit": "minutes"
                            }
                        },
                        {
                            "number": 5,
                            "step": "Add walnuts and serve hot.",
                            "ingredients": [
                                {
                                    "id": 12155,
                                    "name": "walnuts",
                                    "localizedName": "walnuts",
                                    "image": "https://spoonacular.com/cdn/ingredients_100x100/walnuts.jpg"
                                }
                            ],
                            "equipment": []
                        }
                    ]
                }
            ],
            "spoonacularScore": 98.09185028076172,
            "spoonacularSourceUrl": "https://spoonacular.com/broccolini-quinoa-pilaf-715769"
        },

    { // following recipe in JSON }
```

The APIManager struct performs a network request to load recipes asynchronously and return an array of APIRecipe objects. To switch URLs by category and query endpoints, the loadRecipe function is requires a SearchTerm input parameter. SearchTerm is defined as an enumeration with a query and categoryParam case. The URL is created based on a switch case to determine whether the user is searching a recipe versus looking through recipe categories.

```
enum SearchTerm {
    // search recipe
    // ex: query("cake")
    case query(String)
    // cuisine, meal type, diet, intolerance categories
    // ex: categoryParam(param: "cuisine", value: "Italian")
    case categoryParam(param: String, value: String)
}
``` 

### category = Italian
https://api.spoonacular.com/recipes/complexSearch?apiKey=cce86962d1e94f68b85f3fad930d6ee6&addRecipeInformation=true&addRecipeInstructions=true&number=100&cuisine=italian

**URLQueryItems**
| Key  | Value |
| ------------- | ------------- |
| addRecipeInformation  | true  |
| addRecipeInstructions  | true  |
| number  | 100  |
| cuisine  | italian  |

### query = cake
https://api.spoonacular.com/recipes/complexSearch?apiKey=cce86962d1e94f68b85f3fad930d6ee6&addRecipeInformation=true&addRecipeInstructions=true&number=100&query=cake

**URLQueryItems**
| Key  | Value |
| ------------- | ------------- |
| addRecipeInformation  | true  |
| addRecipeInstructions  | true  |
| number  | 100  |
| query  | cake  |
<br>
To throw possible errors, the APIError enum is defined with invalidURL, invalidResponse, exceededCallLimit (402 status code), badStatusCode, and unableToDecode cases. 

# MVVM

## APIRecipe

### Model
The APIRecipe model contains properties and coding keys to be decoded from the Spoonacular API. Those properties are used to show recipe data in the explore and saved recipes view.

### View Model
The APIRecipe viewmodel folder is broken up into 3 files: APIRecipeDetailViewModel, ExploreViewModel, and SavedRecipesViewModel. The ExploreViewModel class contains methods that load recipes by category and search recipes by name. It also contains boolean values to show an alert when the API has exceeded its call limit and to switch between the category and search views. The APIRecipeDetailViewModel contains methods to remove duplicate ingredients and equipment from nested objects in each step. 

### View
The APIRecipe view folder contains composed and custom views for the explore, saved, and detail views. Grid views are reused for the search and category views.

## MyRecipe

### Model
The MyRecipe model contains MyRecipe, Ingredient, Equipment, and Instruction classes for a user to create their own personal cookbook. Ingredient, Equipment, and Instruction objects are initialized separately from the MyRecipe class to be identifiable in a list.

### View Model
The MyRecipe view model folder contains two files to construct the add/edit and detail views. The AddEditRecipeViewModel contains CRUD methods for MyRecipe and other methods to upload an image. The RecipeDetailViewModel contains methods to display the navigation title and prep/cook times.  

### View
The MyRecipe view folder contains composed and custom views to make up the add/edit, detail, and sheet views. 

# SwiftData 
SwiftData is integrated with ChefsKiss to save recipes from the REST API and allow users to create recipes. The model container modifier is added to the WindowGroup view to create a container and context for APIRecipe and MyRecipe. Adding modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:) to a SwiftUI app's Window Group gives the container & context access to the entire app. Views that contain an APIRecipe or MyRecipe object require creating ModelContainer inside the preview or else the preview will crash. Since many views in the app pass these objects, there are reusable structs for previews. The APIRecipePreview and MyRecipePreview files create a sample container and recipe for previews to display. 

## API Recipe
Saved recipes appear in the saved recipes TabView as persisted data. The APIRecipe model, HeartButtonView, and SavedRecipesView files require importing SwiftData. The APIRecipe class calls the @Model macro, so recipes persist when saved from its grid or detail views. It also conforms to the Equatable protocol so that recipe ids can be compared to insert or delete a recipe from the model context. The modelContext property is instantiated with the @Environment macro in the HeartButtonView. When the save button toggles, its action is to insert and delete recipes from the model context. The savedRecipes property is instantiated in the SavedRecipesView and HeartButtonView with the @Query macro to access persisted recipes.

## MyRecipe
Users can create, read, update, and delete recipes in the My Recipes TabView. The MyRecipe model and MyRecipeListView files require importing SwiftData. The MyRecipe model schema is constructed with Ingredient, Equipment, and Instruction classes as nested objects, each conforming to the @Model macro. To access persisted data inside the MyRecipe model container, the recipes property is instantiated inside the MyRecipeListView with the @Query macro. Recipes are read from a list in the my recipe TabView as custom row items. When creating or updating a recipe, the recipe is passed to the same view. Swiping left on a recipe in the list view will delete a recipe from the model context.

The AddEditRecipeView is a form where ingredients, equipment, and instructions are made up of a list view. A sheet will appear when tapping its plus button to input necessary data for each object. Once an item is added, the user can tap on its list row view to edit the item. Step items in the InstructionsListView can be moved in any particular order with the onMove(perform:) modifier. Each step will automatically update its index number accordingly.

# PhotosUI
PhotosUI is imported to render and save a photo from the user’s album to be displayed in the recipe detail view. A recipe image is stored in the Recipe model as an optional Data? type. Inside the AddEditRecipeView, there is a section inside the form that contains a .overlay modifier containing a PhotosPicker view. There are 5 cases: empty, loading, savedImage, success, cameraImage, and failure defined by an enum that will alter the image section. 

When the user taps the PhotosPicker view and selects a photo asset, the selectedPhoto/PhotosPickerItem is determined by a computed property and converted to Data by the loadTransferable(from:) function. The function determines whether Progress is a success or failure case. The user also has the option to upload an image from the camera by tapping the on CameraButtonView. The button toggles and presents the CameraView with a .fullScreenCover modifier. To integrate UIImagePickerController from UIKit into SwiftUI, CameraView conforms to UIViewControllerRepresentable.

# Improvements
ChefsKiss currently has two bugs. The first bug occurs when unsaving a recipe from the ExploreView. When the user reloads the app, saved recipes are unable to be unsaved when tapping the heart button inside the grid view and image view. However, recipes can be unsaved inside the SavedRecipesView. A possible solution could be having SwiftData follow MVVM so that the model context is updated in the view model rather than each view. 

The second bug occurs after saving a recipe. Once the user taps the heart button and proceeds to the SavedRecipesView, the AsyncImage does not fully load and indicates an error by displaying the placeholder image. However, when the user reloads the app, the recipe image appears.  

Additional improvements include adding a filter and sort button to the navigation bar inside the MyRecipesView. After adding vegan, vegetarian, gluten-free, and dairy-free options to the AddEditRecipeView form, the filter button would categorize recipes by those dietary restrictions. The sort button action would be to sort recipes by ascending or descending alphabetical order. 
