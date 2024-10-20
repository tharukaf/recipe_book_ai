import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/utils/titles.dart';

class RecipePrepItem extends StatelessWidget {
  RecipePrepItem({
    super.key,
    required this.index,
    required this.ingredient,
    required this.changeCheckboxValue,
  });

  final int index;
  final Ingredient ingredient;
  final void Function(int, bool?) changeCheckboxValue;

  Color changeIngredientBackground() {
    if (ingredient.isDone) {
      return const Color.fromARGB(111, 76, 58, 78);
    } else {
      if (index.isOdd) {
        return const Color.fromARGB(52, 176, 92, 189);
      } else {
        return const Color.fromARGB(36, 176, 92, 189);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: changeIngredientBackground(),
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(97, 206, 147, 216)!,
          ),
        ),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: ingredient.isDone,
              onChanged: (bool? value) {
                changeCheckboxValue(index, value);
              },
            ),
            Text(
              '${ingredient.quantity}${ingredient.unit} ${ingredient.name}',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: ingredient.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
