import 'dart:core';
import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/utils/titles.dart';
import 'package:recipe_book_ai/widgets/add_new_ingredient.dart';
import 'package:recipe_book_ai/widgets/recipe_cook_items.dart';
import 'package:recipe_book_ai/widgets/recipe_prep_items.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe? recipe;
  final bool isNewRecipe;

  const RecipeDetailScreen({
    super.key,
    this.recipe,
    required this.isNewRecipe,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Recipe? recipe;

  handleAddNewIngredient(Ingredient ingredient) {
    setState(() {
      recipe!.ingredients!.add(ingredient);
    });
  }

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
  }

  void changeCheckboxValue(int index, bool? value) {
    setState(() {
      recipe!.ingredients![index].isDone = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 2;
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        floatingActionButton: NewIngredientDialog(
          ingredientIndex: recipe!.ingredients!.length,
          recipe: recipe!,
          handleAddNewIngredient: handleAddNewIngredient,
        ),
        appBar: AppBar(
          title: Text(recipe!.title),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.shopping_cart),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.soup_kitchen),
                text: titles[1],
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          RecipePrepItems(
              changeCheckboxValue: changeCheckboxValue,
              ingredientList: recipe!.ingredients!),
          RecipeCookItems(cookingSteps: recipe!.cookingSteps!),
        ]),
      ),
    );
  }
}
