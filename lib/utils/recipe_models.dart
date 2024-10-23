import 'package:flutter/material.dart';

class Ingredient {
  int id;
  String name;
  double quantity;
  String? unit;
  String? preparation;
  bool isDone;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isDone,
  });
}

class CookingStep {
  int stepNumber;
  String description;
  Duration duration;

  CookingStep({
    required this.stepNumber,
    required this.description,
    this.duration = Duration.zero,
  });
}

class Recipe {
  String id;
  String title;
  String? description;
  String? imagePath;
  List<String>? tags;
  final List<Ingredient>? ingredients;
  final List<CookingStep>? cookingSteps;

  Recipe({
    required this.id,
    required this.title,
    this.description,
    this.imagePath,
    this.ingredients,
    this.cookingSteps,
    this.tags,
  });
}

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
}
