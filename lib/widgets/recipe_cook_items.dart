import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/widgets/recipe_cook_item.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';

class RecipeCookItems extends StatefulWidget {
  final List<CookingStep> cookingSteps;

  RecipeCookItems({
    super.key,
    required this.cookingSteps,
  });

  @override
  State<RecipeCookItems> createState() => _RecipeCookItemsState();
}

class _RecipeCookItemsState extends State<RecipeCookItems> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: ListView.builder(
            itemCount: widget.cookingSteps.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipeCookItem(
                cookingStep: widget.cookingSteps[index],
              );
            },
          )),
    );
  }
}
