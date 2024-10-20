import 'package:recipe_book_ai/utils/recipe_models.dart';

final mockRecipes = <Recipe>[
  Recipe(
    id: 1,
    title: 'Spaghetti Carbonara',
    description: 'A classic Italian pasta dish',
    imagePath: 'assets/images/spaghetti_carbonara.jpg',
    ingredients: [
      Ingredient(id: 1, name: 'Spaghetti', quantity: 200, unit: 'g'),
      Ingredient(id: 2, name: 'Eggs', quantity: 4, unit: ''),
      Ingredient(id: 3, name: 'Parmesan cheese', quantity: 50, unit: 'g'),
      Ingredient(id: 4, name: 'Pancetta', quantity: 100, unit: 'g'),
      Ingredient(id: 5, name: 'Black pepper', quantity: 0, unit: 'to taste'),
    ],
    cookingSteps: [
      CookingStep(stepNumber: 1, description: 'Boil the spaghetti.'),
      CookingStep(stepNumber: 2, description: 'Fry the pancetta.'),
      CookingStep(stepNumber: 3, description: 'Mix eggs and cheese.'),
      CookingStep(stepNumber: 4, description: 'Combine all ingredients.'),
    ],
  ),
  Recipe(
    id: 2,
    title: 'Chicken Curry',
    description: 'A spicy and flavorful chicken curry',
    imagePath: 'assets/images/chicken_curry.jpg',
    ingredients: [
      Ingredient(id: 1, name: 'Chicken', quantity: 500, unit: 'g'),
      Ingredient(id: 2, name: 'Onions', quantity: 2, unit: ''),
      Ingredient(id: 3, name: 'Tomatoes', quantity: 3, unit: ''),
      Ingredient(id: 4, name: 'Garlic', quantity: 4, unit: ''),
      Ingredient(id: 5, name: 'Curry powder', quantity: 2, unit: 'tbsp'),
    ],
    cookingSteps: [
      CookingStep(stepNumber: 1, description: 'Chop the onions and garlic.'),
      CookingStep(stepNumber: 2, description: 'Fry the onions and garlic.'),
      CookingStep(stepNumber: 3, description: 'Add chicken and cook.'),
      CookingStep(stepNumber: 4, description: 'Add tomatoes and curry powder.'),
      CookingStep(
          stepNumber: 5, description: 'Simmer until chicken is cooked.'),
    ],
  ),
  Recipe(
    id: 3,
    title: 'Chocolate Cake',
    description: 'A rich and moist chocolate cake',
    imagePath: 'assets/images/chocolate_cake.jpg',
    ingredients: [
      Ingredient(id: 1, name: 'Flour', quantity: 200, unit: 'g'),
      Ingredient(id: 2, name: 'Sugar', quantity: 200, unit: 'g'),
      Ingredient(id: 3, name: 'Cocoa powder', quantity: 50, unit: 'g'),
      Ingredient(id: 4, name: 'Baking powder', quantity: 1, unit: 'tsp'),
      Ingredient(id: 5, name: 'Eggs', quantity: 3, unit: ''),
      Ingredient(id: 6, name: 'Butter', quantity: 100, unit: 'g'),
      Ingredient(id: 7, name: 'Milk', quantity: 200, unit: 'ml'),
    ],
    cookingSteps: [
      CookingStep(stepNumber: 1, description: 'Preheat the oven to 180°C.'),
      CookingStep(stepNumber: 2, description: 'Mix dry ingredients.'),
      CookingStep(stepNumber: 3, description: 'Add wet ingredients and mix.'),
      CookingStep(stepNumber: 4, description: 'Pour into a baking tin.'),
      CookingStep(stepNumber: 5, description: 'Bake for 30 minutes.'),
    ],
  ),
];
