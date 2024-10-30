import 'package:flutter/material.dart';
import 'package:recipe_book_ai/models/recipe.dart';

class Recipes extends ChangeNotifier {
  Map recipes = <String, Recipe>{};
  int get length => recipes.length;

  Recipe operator [](int index) =>
      recipes.isNotEmpty ? recipes.values.elementAt(index) : Recipe.empty();

  Recipes(
    this.recipes,
  );

  List<Recipe> getRecipeList() {
    return recipes.values.toList().cast<Recipe>();
  }

  Recipes.empty() {
    recipes = <String, Recipe>{};
  }

  Recipe getRecipeById(Recipe recipe) {
    return recipes[recipe.id] ?? recipe;
  }

  void addRecipe(Recipe recipe) {
    recipes[recipe.id] = recipe;
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    recipes[recipe.id] = recipe;
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    recipes.remove(recipe.id);
    notifyListeners();
  }
}
