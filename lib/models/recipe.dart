import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:flutter/material.dart';

class Recipe extends ChangeNotifier {
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

  void addIngredient(Ingredient ingredient) {
    ingredients!.add(ingredient);
    notifyListeners();
  }

  void addCookingStep(CookingStep cookingStep) {
    cookingSteps!.add(cookingStep);
    notifyListeners();
  }

  void updateIngredient(Ingredient ingredient) {
    final index =
        ingredients!.indexWhere((element) => element.id == ingredient.id);
    if (index != -1) {
      ingredients![index] = ingredient;
    }
    notifyListeners();
  }

  void updateCookingStep(CookingStep cookingStep) {
    final index = cookingSteps!
        .indexWhere((element) => element.stepNumber == cookingStep.stepNumber);
    if (index != -1) {
      cookingSteps![index] = cookingStep;
    }
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients!.remove(ingredient);
    for (var i = 0; i < ingredients!.length; i++) {
      ingredients![i].id = i + 1;
    }
    notifyListeners();
  }

  void removeCookingStep(CookingStep cookingStep) {
    cookingSteps!.remove(cookingStep);
    for (var i = 0; i < cookingSteps!.length; i++) {
      cookingSteps![i].stepNumber = i + 1;
    }
    notifyListeners();
  }
}
