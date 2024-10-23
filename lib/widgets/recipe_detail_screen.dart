import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int tabIndex = 0;

  void handleAddNewIngredient(Ingredient ingredient) {
    setState(() {
      recipe?.ingredients?.add(ingredient);
    });
  }

  void handleAddNewCookStep(CookingStep step) {
    setState(() {
      recipe?.cookingSteps?.add(step);
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
    final newIngredientDialog = NewIngredientDialog(
      ingredientIndex: recipe!.ingredients!.length,
      recipe: recipe!,
      handleAddNewIngredient: handleAddNewIngredient,
    );
    final newCookingStepDialog = NewCookingStepDialog(
        stepIndex: recipe!.cookingSteps!.length,
        recipe: recipe!,
        handleAddNewCookStep: handleAddNewCookStep);
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: DefaultTabControllerListener(
        onTabChanged: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        child: Scaffold(
          floatingActionButton:
              tabIndex == 0 ? newIngredientDialog : newCookingStepDialog,
          appBar: AppBar(
            title: Text(widget.isNewRecipe ? 'Add New Recipe' : recipe!.title,
                style: GoogleFonts.deliusSwashCaps()),
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
                recipe: recipe!,
                isNewRecipe: widget.isNewRecipe,
                changeCheckboxValue: changeCheckboxValue,
                ingredientList: recipe!.ingredients!),
            RecipeCookItems(cookingSteps: recipe!.cookingSteps!),
          ]),
        ),
      ),
    );
  }
}

class DefaultTabControllerListener extends StatefulWidget {
  const DefaultTabControllerListener({
    required this.onTabChanged,
    required this.child,
    super.key,
  });

  final ValueChanged<int> onTabChanged;

  final Widget child;

  @override
  State<DefaultTabControllerListener> createState() =>
      _DefaultTabControllerListenerState();
}

class _DefaultTabControllerListenerState
    extends State<DefaultTabControllerListener> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final TabController? defaultTabController =
        DefaultTabController.maybeOf(context);

    assert(() {
      if (defaultTabController == null) {
        throw FlutterError(
          'No DefaultTabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.',
        );
      }
      return true;
    }());

    if (defaultTabController != _controller) {
      _controller?.removeListener(_listener);
      _controller = defaultTabController;
      _controller?.addListener(_listener);
    }
  }

  void _listener() {
    final TabController? controller = _controller;

    if (controller == null || controller.indexIsChanging) {
      return;
    }

    widget.onTabChanged(controller.index);
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
