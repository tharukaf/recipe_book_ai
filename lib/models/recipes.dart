import 'package:flutter/material.dart';
import 'package:recipe_book_ai/models/recipe.dart';

class Recipes extends ChangeNotifier {
  List<Recipe> recipes = <Recipe>[];
  int get length => recipes.length;

  Recipe operator [](int index) => recipes[index];

  Recipes(
    this.recipes,
  );

  Recipes.empty() {
    recipes = <Recipe>[];
  }

  Recipe getRecipeById(Recipe recipe) {
    return recipes.firstWhere((element) => element.id == recipe.id,
        orElse: () => recipe);
  }

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    final index = recipes.indexWhere((element) => element.id == recipe.id);
    if (index != -1) {
      recipes[index] = recipe;
      notifyListeners();
    }
  }

  void removeRecipe(Recipe recipe) {
    recipes.remove(recipe);
    notifyListeners();
  }

  // Recipes to Json
  List<Map<String, dynamic>> toJson() {
    return recipes.map((recipe) => recipe.toMap()).toList();
  }
}
