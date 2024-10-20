import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/widgets/recipe_detail_screen.dart';

class AddRecipeScreen extends StatelessWidget {
  AddRecipeScreen({super.key});

  late Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return RecipeDetailScreen(isNewRecipe: true);
  }
}
