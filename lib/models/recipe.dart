import 'package:localstore/localstore.dart';
import 'package:nanoid/nanoid.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:flutter/material.dart';

class Recipe extends ChangeNotifier {
  String id;
  String title;
  String? description;
  String? imagePath;
  double? rating;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<CookingStep> cookingSteps;

  Recipe({
    required this.id,
    required this.title,
    this.description,
    this.imagePath,
    this.rating,
    required this.ingredients,
    required this.cookingSteps,
    required this.tags,
  });

  Recipe.empty()
      : id = nanoid(),
        title = '',
        description = '',
        imagePath = '',
        rating = 0.0,
        ingredients = [],
        cookingSteps = [],
        tags = [];

  void addTag(String tag) {
    tags.add(tag);
    notifyListeners();
  }

  // Recipe to Json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'rating': rating,
      'tags': tags,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toMap()).toList(),
      'cookingSteps':
          cookingSteps.map((cookingStep) => cookingStep.toMap()).toList(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] ?? nanoid(),
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'] ?? '',
      rating: map['rating'] ?? 0.0,
      tags: List<String>.from(map['tags']),
      ingredients: List<Ingredient>.from(
          map['ingredients'].map((x) => Ingredient.fromMap(x))),
      cookingSteps: List<CookingStep>.from(
          map['cookingSteps'].map((x) => CookingStep.fromMap(x))),
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe.fromMap(json['Recipe']);
  }

  void updateRating(double newRating) {
    rating = newRating;
    notifyListeners();
    save();
  }

  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
    notifyListeners();
    save();
  }

  void addCookingStep(CookingStep cookingStep) {
    cookingSteps.add(cookingStep);
    notifyListeners();
    save();
  }

  void updateIngredient(Ingredient ingredient) {
    final index =
        ingredients.indexWhere((element) => element.id == ingredient.id);
    if (index != -1) {
      ingredients[index] = ingredient;
    }
    notifyListeners();
    save();
  }

  void deleteCookingStep(CookingStep cookingStep) {
    cookingSteps.remove(cookingStep);
    notifyListeners();
    save();
  }

  void updateCookingStep(CookingStep cookingStep) {
    final index = cookingSteps
        .indexWhere((element) => element.stepNumber == cookingStep.stepNumber);
    if (index != -1) {
      cookingSteps[index] = cookingStep;
    }
    notifyListeners();
    save();
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients.remove(ingredient);
    for (var i = 0; i < ingredients.length; i++) {
      ingredients[i].id = i + 1;
    }
    notifyListeners();
    save();
  }

  void removeCookingStep(CookingStep cookingStep) {
    cookingSteps.remove(cookingStep);
    for (var i = 0; i < cookingSteps.length; i++) {
      cookingSteps[i].stepNumber = i + 1;
    }
    notifyListeners();
    save();
  }
}

extension ExtRecipe on Recipe {
  // Save the recipe to the database
  Future save() async {
    final db = Localstore.instance;
    return db.collection('recipes').doc(id).set(toMap());
  }

  Future delete() async {
    final db = Localstore.instance;
    return db.collection('recipes').doc(id).delete();
  }
}
