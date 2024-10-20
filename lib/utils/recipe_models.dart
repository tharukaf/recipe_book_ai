class Ingredient {
  int id;
  String name;
  double quantity;
  String? unit;
  String? preparation;
  bool? isDone;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.preparation,
    this.isDone,
  });
}

class CookingStep {
  final int stepNumber;
  final String description;
  final String? duration;

  CookingStep({
    required this.stepNumber,
    required this.description,
    this.duration,
  });
}

class Recipe {
  final int id;
  final String title;
  final String? description;
  final String? imagePath;
  final List<Ingredient>? ingredients;
  final List<CookingStep>? cookingSteps;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.ingredients,
    required this.cookingSteps,
  });
}
