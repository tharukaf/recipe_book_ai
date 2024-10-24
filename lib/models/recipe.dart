import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/ingredient.dart';

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

  void addIngredient(Ingredient ingredient) {
    ingredients!.add(ingredient);
  }

  void addCookingStep(CookingStep cookingStep) {
    cookingSteps!.add(cookingStep);
  }

  void updateIngredient(Ingredient ingredient) {
    final index =
        ingredients!.indexWhere((element) => element.id == ingredient.id);
    if (index != -1) {
      ingredients![index] = ingredient;
    }
  }

  void updateCookingStep(CookingStep cookingStep) {
    final index = cookingSteps!
        .indexWhere((element) => element.stepNumber == cookingStep.stepNumber);
    if (index != -1) {
      cookingSteps![index] = cookingStep;
    }
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients!.remove(ingredient);
  }

  void removeCookingStep(CookingStep cookingStep) {
    cookingSteps!.remove(cookingStep);
  }
}
