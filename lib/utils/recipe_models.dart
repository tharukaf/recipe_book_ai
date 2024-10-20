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
    this.preparation,
    required this.isDone,
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
  final List<String>? tags;

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
