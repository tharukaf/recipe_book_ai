import 'dart:core';
import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/utils/titles.dart';
import 'package:recipe_book_ai/widgets/add_new_ingredient.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:recipe_book_ai/widgets/recipe_prep_item.dart';

class ResponsiveRecipeDetailItems extends StatelessWidget {
  final List<Ingredient>? ingredientList;
  final void Function(int, bool?) changeCheckboxValue;

  const ResponsiveRecipeDetailItems({
    super.key,
    required this.changeCheckboxValue,
    required this.ingredientList,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: RecipePrepItems(
          ingredientList: ingredientList!,
          changeCheckboxValue: changeCheckboxValue),
    );
  }
}

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
    if (widget.isNewRecipe) {
      recipe = Recipe(
        id: 0,
        title: '',
        description: '',
        imagePath: '',
        ingredients: <Ingredient>[],
        cookingSteps: <CookingStep>[],
      );
    } else {
      recipe = widget.recipe;
    }
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
          title: const Text('Recipe Title'),
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
          ResponsiveRecipeDetailItems(
              changeCheckboxValue: changeCheckboxValue,
              ingredientList: recipe!.ingredients),
          const Icon(Icons.soup_kitchen),
        ]),
      ),
    );
  }
}

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
    return Padding(
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
    );
  }
}
