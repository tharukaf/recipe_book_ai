import 'package:recipe_book_ai/models/cooking_step.dart';

// Calculate the quantity of the ingredient based on the serving size
String getIngredientQuantityString(double servingSize, Ingredient ingredient) {
  String quantityString = '';
  bool isWholeNumber = (ingredient.quantity * servingSize) % 1 == 0;
  bool isKgOrL = (ingredient.unit == 'g' || ingredient.unit == 'ml') &&
      ingredient.quantity * servingSize >= 1000;

  if (isWholeNumber) {
    quantityString = isKgOrL
        ? (ingredient.quantity * servingSize / 1000).toString()
        : (ingredient.quantity * servingSize).floor().toString();
  } else {
    quantityString = (ingredient.quantity * servingSize).toStringAsFixed(3);
  }

  quantityString += ' ';

  if (isKgOrL) {
    quantityString += ingredient.unit == 'g' ? 'kg' : 'l';
  } else {
    quantityString += ingredient.unit ?? '';
  }
  return quantityString;
}
