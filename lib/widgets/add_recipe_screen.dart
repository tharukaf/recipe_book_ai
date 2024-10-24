import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:recipe_book_ai/widgets/recipe_detail_screen.dart';

// ignore: must_be_immutable
class AddRecipeScreen extends StatelessWidget {
  AddRecipeScreen({super.key});

  Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    recipe = Recipe(
      id: nanoid(),
      title: '',
      description: '',
      imagePath: '',
      ingredients: <Ingredient>[],
      cookingSteps: <CookingStep>[],
    );

    return RecipeDetailScreen(
      isNewRecipe: true,
      recipe: recipe,
    );
  }
}
