import 'package:nanoid/nanoid.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/ingredient.dart';

final mockRecipes = <Recipe>[
  Recipe(
    id: nanoid(),
    title: 'Spaghetti Carbonara',
    description: 'A classic Italian pasta dish',
    imagePath: 'assets/images/spaghetti_carbonara.jpg',
    ingredients: [
      Ingredient(
          id: 1, name: 'Spaghetti', quantity: 200, unit: 'g', isDone: true),
      Ingredient(id: 2, name: 'Eggs', quantity: 4, unit: '', isDone: false),
      Ingredient(
          id: 3,
          name: 'Parmesan cheese',
          quantity: 50,
          unit: 'g',
          isDone: false),
      Ingredient(
          id: 4, name: 'Pancetta', quantity: 100, unit: 'g', isDone: false),
      Ingredient(
          id: 5,
          name: 'Black pepper',
          quantity: 0,
          unit: 'to taste',
          isDone: false),
    ],
    cookingSteps: [
      CookingStep(
          stepNumber: 1,
          description: 'Boil the spaghetti.',
          duration: const Duration(minutes: 10)),
      CookingStep(
          stepNumber: 2,
          description: 'Fry the pancetta.',
          duration: const Duration(minutes: 5)),
      CookingStep(
          stepNumber: 3,
          description: 'Mix eggs and cheese.',
          duration: const Duration(seconds: 5)),
      CookingStep(stepNumber: 4, description: 'Combine all ingredients.'),
    ],
    tags: ['Pasta', 'Italian', 'Savory'],
  ),
  Recipe(
    id: nanoid(),
    title: 'Chicken Curry',
    description: 'A spicy and flavorful chicken curry',
    imagePath: 'assets/images/chicken_curry.jpg',
    ingredients: [
      Ingredient(
          id: 1, name: 'Chicken', quantity: 500, unit: 'g', isDone: false),
      Ingredient(id: 2, name: 'Onions', quantity: 2, unit: '', isDone: false),
      Ingredient(id: 3, name: 'Tomatoes', quantity: 3, unit: '', isDone: false),
      Ingredient(id: 4, name: 'Garlic', quantity: 4, unit: '', isDone: false),
      Ingredient(
          id: 5,
          name: 'Curry powder',
          quantity: 2,
          unit: 'tbsp',
          isDone: false),
    ],
    cookingSteps: [
      CookingStep(stepNumber: 1, description: 'Chop the onions and garlic.'),
      CookingStep(stepNumber: 2, description: 'Fry the onions and garlic.'),
      CookingStep(stepNumber: 3, description: 'Add chicken and cook.'),
      CookingStep(stepNumber: 4, description: 'Add tomatoes and curry powder.'),
      CookingStep(
          stepNumber: 5, description: 'Simmer until chicken is cooked.'),
    ],
    tags: ['Chicken', 'Curry', 'Spicy'],
  ),
  Recipe(
    id: nanoid(),
    title: 'Chocolate Cake',
    description: 'A rich and moist chocolate cake',
    imagePath: 'assets/images/chocolate_cake.jpg',
    ingredients: [
      Ingredient(id: 1, name: 'Flour', quantity: 200, unit: 'g', isDone: false),
      Ingredient(id: 2, name: 'Sugar', quantity: 200, unit: 'g', isDone: false),
      Ingredient(
          id: 3, name: 'Cocoa powder', quantity: 50, unit: 'g', isDone: false),
      Ingredient(
          id: 4,
          name: 'Baking powder',
          quantity: 1,
          unit: 'tsp',
          isDone: false),
      Ingredient(id: 5, name: 'Eggs', quantity: 3, unit: '', isDone: false),
      Ingredient(
          id: 6, name: 'Butter', quantity: 100, unit: 'g', isDone: false),
      Ingredient(id: 7, name: 'Milk', quantity: 200, unit: 'ml', isDone: false),
    ],
    cookingSteps: [
      CookingStep(stepNumber: 1, description: 'Preheat the oven to 180°C.'),
      CookingStep(stepNumber: 2, description: 'Mix dry ingredients.'),
      CookingStep(stepNumber: 3, description: 'Add wet ingredients and mix.'),
      CookingStep(stepNumber: 4, description: 'Pour into a baking tin.'),
      CookingStep(stepNumber: 5, description: 'Bake for 30 minutes.'),
    ],
    tags: ['Sweet', 'Cake', 'Chocolate', 'Dessert'],
  ),
];
