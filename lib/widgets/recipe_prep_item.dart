import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/utils/servings.dart';
import 'package:recipe_book_ai/widgets/clickable_item.dart';
import 'package:recipe_book_ai/widgets/dialogs/edit_prep_item_dialogs.dart';

class RecipePrepItem extends StatelessWidget {
  const RecipePrepItem({
    super.key,
    required this.recipe,
    required this.handleChangePrepItem,
    required this.handleRemovePrepItem,
    required this.index,
    required this.servingSize,
    required this.ingredient,
    required this.changeCheckboxValue,
  });

  final Recipe recipe;
  final double servingSize;
  final void Function(int, Ingredient) handleChangePrepItem;
  final void Function(Ingredient) handleRemovePrepItem;
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
    return ClickableItem(
      onPressed: () => prepItemShortPressDialog(
        recipe,
        context,
        ingredient,
        handleRemovePrepItem,
        handleChangePrepItem,
        index,
      ),
      onLongPress: () => prepItemLongPressDialog(
        recipe,
        context,
        handleRemovePrepItem,
        index,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: changeIngredientBackground(),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(97, 206, 147, 216),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ingredient.isDone
                      ? const Color.fromARGB(111, 76, 58, 78)
                      : const Color.fromARGB(246, 255, 192, 239),
                ),
                child: Text(
                  getIngredientQuantityString(servingSize, ingredient),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 6),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                // constraints: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  ingredient.name,
                  style: GoogleFonts.deliusSwashCaps(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: ingredient.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
