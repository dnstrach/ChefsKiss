# [ChefsKiss](https://apps.apple.com/us/app/chefskiss/id6738972491)
ChefsKiss is a mobile recipe app built for users who love to cook! Key features include exploring 365,000+ recipes, saving favorite recipes, and creating a personal cookbook. Check out my [portfolio](https://dominiquestrachan.squarespace.com) to see features.

# REST API
The [Spoonacular API](https://spoonacular.com/food-api/docs#Search-Recipes-Complex) is integrated with ChefsKiss to show recipes by categories or search for a recipe by its query. To decode the API response, the APIRecipe model is separated into Response and APIRecipe classes since the JSON object contains nested objects. 

## JSON Response
(https://api.spoonacular.com/recipes/complexSearch?apiKey=cce86962d1e94f68b85f3fad930d6ee6&addRecipeInformation=true&addRecipeInstructions=true&number=100&cuisine=italian)

The response below shows the results object containing the first nested recipe object when the "cuisine" key is equal to the "italian" value.

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
## APIManager 
The APIManager struct performs a network request to load recipes asynchronously and return an array of APIRecipe objects. To switch URLs by category and query endpoints, the loadRecipe function requires a SearchTerm input parameter. SearchTerm is defined as an enumeration with a query and categoryParam case. The URL is created based on a switch case to determine whether the user is searching a recipe versus looking through recipe categories.

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
The Response and APIRecipe classes contain properties and coding keys to be decoded from the Spoonacular API. Those properties show recipe data in the ExploreRecipesView and SavedRecipesView tab views.

### View Model
The ViewModel/APIRecipe pathway is broken up into 2 classes: APIRecipeDetailViewModel and ExploreViewModel. The ExploreViewModel class contains 2 asynchronous methods that load recipes by category and search recipes by name. Both  **loadCategoryRecipes(searchTerm: SearchTerm) async** and **searchRecipes(query: String) async** methods require SearchTerm as an input parameter to determine whether the network request is a recipe category or recipe search query. Once the network request loads, the loading animation is set to false. The view will then be assigned to category results, search results, or an empty search case. If the status code is 402, the catch statement will show an alert to notify the user that the API has exceeded its call limit. The APIRecipeDetailViewModel class determines the grid view and removes duplicate ingredients and equipment from each nested step object.

### View
The ExploreView switches its view based on the ExploreViewResults enum. When the @Published exploreView property is assigned to the category case, ExploreView will switch to the CategoryGridView. The CategoryGridView requires the category’s title (Cuisines, Dish Types, Diets, and Intolerances) and the api categoryKey (cuisine, type, diet, and intolerances). The horizontal grid comprises 4 rows determined by a switch statement. The switch statement switches based on the CategoryKey enum, and each case consists of a ForEach loop. The ForEach loop can iterate over the category enums since they conform to CaseIterable. When the user taps on one of the LazyHGrid items, a NavigationLink will present RecipesView and assign the navigation title. Since the ExploreRecipesViewModel dependency is injected in RecipesView, it therefore initializes searchTerm while calling the **loadCategoryRecipes(searchTerm: SearchTerm) async** method when the user taps on the navigation link in CategoryGridView. The RecipesView comprises RecipesGridView to show recipes with their api image and title. Images are loaded with AsyncImage that will either display the api image, a placeholder image (if there is no api image), or a loading animation. Each grid item contains a navigation link to present APIRecipeDetailView. 

APIRecipeDetailView is composed of 10 views. Some unique design decisions include a hidden navigation bar, an expand button for the recipe summary, and a scroll button that jumps to the initial view.    

## MyRecipe

### Model
The MyRecipe model is constructed with nested Ingredient, Equipment, and Instruction classes all conforming to Identifiable. 

### ViewModel
The ViewModel/MyRecipe pathway is made up of AddEditRecipeViewModel and RecipeDetailViewModel classes. The AddEditRecipeViewModel contains properties and methods to collect and maintain recipe data submitted by a Form. 

When selecting a photo from PhotosPicker, the **loadTransferable(from:)**  method will return a Progress object. Progress is determined by **loadTransferable(type:completionHandler:)** to load PhotosPickerItem as Data to be converted to UIImage in ImagePickerView. Success values from Result determine if there is a selected image Camera or if there is a selected image from Photos. The **loadTransferable(from:)** method is called from a **var selectedPhoto: PhotosPickerItem? { get set }** with a didSet property observer that determines the Progress object and the ImageState. The **saveImage(_:)** method saves the selectedPhoto by calling **loadTransferable(type:)** to convert the PhotoPickerItem to a UIImage. **jpegData(compressionQuality:)** returns the UIImage in JPEG format to be compressed for best quality.

To add ingredients, equipment, and instructions in a List, AddEditRecipeViewModel will initialize the Ingredients, Equipment, and Instruction objects and append them to an array. Steps are moved by the **moveStep(index:destination:)** method. The step’s number will automatically update when being moved in either direction of the list. 
```
    func moveStep(index: IndexSet, destination: Int) {
        var sorted = sortedInstructions
        
        sorted.move(fromOffsets: index, toOffset: destination)

        for index in index {
            print("index: \(index)")
            print("destination: \(destination)")
            
            // if + number then item is being moved forward
            if index - destination > 0 {
                // range is from destination index to included original index
                for i in destination..<index + 1 {
                        sorted[i].index += 1
                    }
                
                // update destination index since it's included in range
                sorted[destination].index = destination
                
            // if - number then item is being moved backwards
            } else if index - destination < 0 {
                // range - original index to destination index
                // note: destination is index + 1
                for i in index..<destination {
                        sorted[i].index -= 1
                    }
                
                // update destination index since it's included in range
                sorted[destination - 1].index = destination - 1
            }
            
            instructions = sorted
        }
        
        for step in instructions {
            print("index: \(step.index) step: \(step.step)")
        }
        
        print("end")
        
    }
```
RecipeDetailViewModel contains properties to show the edit sheet and input GridItem.Size. Its methods return Bool values to determine when to show servings, prep time, and cook time.

### View
Recipes are accessible in the MyRecipesListView. Once the user taps on a recipe, a navigation link will present its detail view. To add or edit a recipe, AddEditRecipeView is presented as a sheet. To select a recipe image, the user must tap on the ImagePickerView section. ImagePickerView contains **PhotosPicker** layered in front of a HStack by the **overlay(alignment:content:)** modifier. The selected image is displayed by ImageState with a switch statement to show empty, loading, savedImage, photoImage, cameraImage, and failure case values.

The user can also select an image from their built-in camera. The button above **PhotosPicker** will present the Camera app as a modal view by the **fullScreenCover(isPresented:onDismiss:content:)** modifier. CameraView conforms to **UIViewControllerRepresentable** to manage **UIImagePickerController** in a SwiftUI interface. 

To add ingredients, equipment, and instructions, the user must tap on a plus button to present a sheet that take ups 25% of the screen. An item can be edited by tapping on the list item to present the edit sheet.

# SwiftData 
SwiftData is integrated with ChefsKiss to save recipes from the REST API and create persistent recipes in the MyRecipes tab. The model container modifier is added to the WindowGroup view to create a container for APIRecipe and MyRecipe. Adding the **modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:)** modifier to a SwiftUI app's Window Group gives the container & context access to the entire app. Views that contain an APIRecipe or MyRecipe object require creating an instance of ModelContainer inside the preview or else the preview will crash. Since various views in the app pass these objects, APIRecipePreview and MyRecipePreview initialize a sample container and recipe for previews. 

## API Recipe
APIRecipe, HeartButtonView, and SavedRecipesView require importing SwiftData. The APIRecipe class calls the **@Model** macro, so recipes persist when saved from the grid or detail view. This class also conforms to the Equatable protocol so that recipe ids can be compared when inserting or deleting a recipe from the model context. The modelContext property is instantiated with the @Environment macro in the HeartButtonView. When the save button toggles, its action is to insert and delete recipes from the model context. The savedRecipes property is instantiated in the SavedRecipesView and HeartButtonView with the **@Query** macro to access persisted recipes.

## MyRecipe
Users create, read, update, and delete recipes in the MyRecipes tab. MyRecipe and MyRecipeListView require importing **SwiftData**. The MyRecipe model schema is constructed with Ingredient, Equipment, and Instruction classes as nested objects, each conforming to the **@Model** macro. To access persisted data inside the MyRecipe model container, the recipes property is instantiated inside the MyRecipeListView with the @Query macro. Recipes are read from a list in the MyRecipe tab as custom row items. When creating or updating a recipe, the recipe is passed to the same view. The **onDelete(perform:)** modifier deletes a recipe from the model context when swiping left in the list view.

# PhotosUI
**PhotosUI** is imported to render a photo from Photos. When the user taps the **PhotosPicker** view and selects a photo, the selectedPhoto/PhotosPickerItem is determined by a computed property and converted to Data by the **loadTransferable(from:)** function. The image property from MyRecipe is an optional Data type so that recipes can be easily converted to UIImage. 

# Improvements
ChefsKiss currently has two bugs. The first bug occurs when unsaving a recipe from the ExploreView. When the user reloads the app, saved recipes are unable to be unsaved when tapping the heart button inside the grid view and image view. However, recipes can be unsaved inside the SavedRecipesView. A possible solution could be removing SwiftData macros to follow MVVM architecture, so that the MyRecipe objects are accessed from a viewModel rather than **@Query** and **@Environment(\.modelContext)**. 

The second bug occurs after saving a recipe. Once the user taps the heart button and proceeds to the SavedRecipesView, the **AsyncImage** view does not fully load and displays the placeholder image. However, when the user reloads the app, the recipe image appears.  

Additional improvements include adding a filter and sort button to the navigation bar inside the MyRecipesView. After adding a vegan, vegetarian, gluten-free, and dairy-free picker to the AddEditRecipeView, the filter button would categorize recipes by those dietary restrictions. The sort button action would be to sort recipes by ascending or descending alphabetical order. 
