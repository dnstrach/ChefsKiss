# ChefsKiss

## MVVM
The APIRecipe model contains properties and coding keys to be decoded from the Spoonacular API. Those properties are used to show recipe data in the explore and saved recipes view.

The APIRecipe viewmodel is broken up into 3 files, ExploreViewModel and APIRecipeDetailViewModel. The ExploreViewModel class contains methods that load recipes by category and search recipes by name. It also contains boolean values to show an alert when the API has exceeded its call limit and to switch between the category and search views. The APIRecipeDetailViewModel contains methods to remove from duplicate ingredients and equipment from nested objects in each step. 

```
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
            ]
```

The APIRecipe view folder contains composed views for the Explore, Saved amd APIRecipe Detail view. Grid views are reused for the search and category view.


Recipe Model
MyRecipeViewModel
MyRecipe View

## REST API

## SwiftData (APIRecipe)

## SwiftData (MyRecipe)
CRUD

## PhotosUI

