import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/widgets/recipe_cook_item.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';

class RecipeCookItems extends StatefulWidget {
  final List<CookingStep> cookingSteps;
  final Function(CookingStep) handleAddNewCookStep;
  final Recipe recipe;

  const RecipeCookItems({
    super.key,
    required this.recipe,
    required this.cookingSteps,
    required this.handleAddNewCookStep,
  });

  @override
  State<RecipeCookItems> createState() => _RecipeCookItemsState();
}

class _RecipeCookItemsState extends State<RecipeCookItems> {
  void removeCookingStep(CookingStep step) {
    setState(() {
      widget.recipe.removeCookingStep(step);
    });
  }

  @override
  Widget build(BuildContext context) {
    Recipe recipe =
        Provider.of<Recipes>(context).getRecipeById(widget.recipe.id);
    return ResponsiveLayout(
        child: Consumer<Recipes>(
      builder: (context, recipes, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: ListView.builder(
          itemCount: recipe.cookingSteps.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCookItem(
              cookingStep:
                  recipes.getRecipeById(widget.recipe.id).cookingSteps[index],
              handleAddNewCookStep: widget.handleAddNewCookStep,
              removeCookingStep: removeCookingStep,
              recipe: recipe,
            );
          },
        ),
      ),
    ));
  }
}
