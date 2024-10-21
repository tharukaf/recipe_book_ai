import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/widgets/recipe_prep_item.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';

class RecipePrepItems extends StatelessWidget {
  final List<Ingredient> ingredientList;
  final void Function(int, bool?) changeCheckboxValue;

  const RecipePrepItems({
    super.key,
    required this.ingredientList,
    required this.changeCheckboxValue,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: ListView.builder(
          itemCount: ingredientList.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipePrepItem(
                ingredient: ingredientList[index],
                index: index,
                changeCheckboxValue: changeCheckboxValue);
          },
        ),
      ),
    );
  }
}
