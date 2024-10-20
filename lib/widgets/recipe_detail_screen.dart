import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/utils/titles.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:recipe_book_ai/widgets/recipe_prep_item.dart';

class ResponsiveRecipeDetailItems extends StatelessWidget {
  final List<Ingredient> list;
  final void Function(int, bool?) changeCheckboxValue;

  const ResponsiveRecipeDetailItems({
    super.key,
    required this.changeCheckboxValue,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child:
          RecipePrepItems(list: list, changeCheckboxValue: changeCheckboxValue),
    );
  }
}

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({
    super.key,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  var recipe = Recipe(
    id: 0,
    title: 'Recipe Name',
    description: 'Recipe Description',
    imagePath: 'assets/images/recipe_image.jpg',
    ingredients: <Ingredient>[],
    cookingSteps: <CookingStep>[],
  );
  var ingredient = HashMap<String, String>();

  void changeCheckboxValue(int index, bool? value) {
    setState(() {
      for (Ingredient ingredient in recipe.ingredients!) {
        if (ingredient.name == '${titles[0]} $index') {
          ingredient.isDone = value;
        }
      }
    });
  }

  void addRecipeItem() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Ingredient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter the ingredient',
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        height: 2,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                  DropdownButton(
                    // onChanged: (value) {
                    //   setState(() {
                    //     ingredient['unit'] = value.toString();
                    //   });
                    // },
                    onChanged: (value) => ingredient['unit'] = value.toString(),
                    items: const <DropdownMenuItem>[
                      // DropdownMenuItem(value: Null, child: Text('')),
                      DropdownMenuItem(value: 'g', child: Text('g')),
                      DropdownMenuItem(value: 'kg', child: Text('kg')),
                      DropdownMenuItem(value: 'ml', child: Text('ml')),
                      DropdownMenuItem(value: 'l', child: Text('l')),
                      DropdownMenuItem(value: 'tsp', child: Text('tsp')),
                      DropdownMenuItem(value: 'tbsp', child: Text('tbsp')),
                      DropdownMenuItem(value: 'cup', child: Text('cup')),
                      DropdownMenuItem(value: 'pt', child: Text('pt')),
                      DropdownMenuItem(value: 'qt', child: Text('qt')),
                      DropdownMenuItem(value: 'gal', child: Text('gal')),
                      DropdownMenuItem(value: 'oz', child: Text('oz')),
                      DropdownMenuItem(value: 'lb', child: Text('lb'))
                    ],
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // TODO: Add ingredient to list
                  // list.add(ingredientController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 2;
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: const Color(0xFFFFFFFF),
          shape: const CircleBorder(),
          onPressed: addRecipeItem,
          child: const Icon(Icons.add),
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
              list: recipe.ingredients!),
          const Icon(Icons.soup_kitchen),
        ]),
      ),
    );
  }
}

class RecipePrepItems extends StatelessWidget {
  final List<Ingredient> list;
  final void Function(int, bool?) changeCheckboxValue;

  const RecipePrepItems({
    super.key,
    required this.list,
    required this.changeCheckboxValue,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.10);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return RecipePrepItem(
            oddItemColor: oddItemColor,
            evenItemColor: evenItemColor,
            list: list,
            index: index,
            changeCheckboxValue: changeCheckboxValue);
      },
    );
  }
}
