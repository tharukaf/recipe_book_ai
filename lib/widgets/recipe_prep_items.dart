import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/widgets/edit_recipe_dialog.dart';
import 'package:recipe_book_ai/widgets/recipe_prep_item.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';

// ignore: must_be_immutable
class RecipePrepItems extends StatefulWidget {
  final List<Ingredient> ingredientList;
  final Recipe recipe;
  final bool isNewRecipe;
  final void Function(int, bool?) changeCheckboxValue;

  const RecipePrepItems({
    super.key,
    required this.recipe,
    required this.isNewRecipe,
    required this.ingredientList,
    required this.changeCheckboxValue,
  });

  @override
  State<RecipePrepItems> createState() => _RecipePrepItemsState();
}

class _RecipePrepItemsState extends State<RecipePrepItems> {
  double servingSize = 1;

  void handleChangeServingSize(String operationType) {
    setState(() {
      if (operationType == "add") {
        if (servingSize < 10) servingSize++;
      } else {
        if (servingSize > 1) {
          servingSize--;
        }
      }
    });
  }

  void handleChangePrepItem(int index, Ingredient ingredient) {
    setState(() {
      widget.recipe.ingredients[index] = ingredient;
    });
  }

  void handleRemovePrepItem(int index) {
    setState(() {
      widget.recipe.ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Servings: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => handleChangeServingSize("subtract"),
                        icon: const Icon(Icons.remove),
                      ),
                      SizedBox(
                        width: 20,
                        child: Center(
                          child: Text(
                            servingSize.floor().toString(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => handleChangeServingSize("add"),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 270,
                child: ListView.builder(
                  itemCount: widget.ingredientList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipePrepItem(
                        servingSize: servingSize,
                        ingredient: widget.ingredientList[index],
                        recipe: widget.recipe,
                        handleChangePrepItem: handleChangePrepItem,
                        handleRemovePrepItem: handleRemovePrepItem,
                        index: index,
                        changeCheckboxValue: widget.changeCheckboxValue);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll<Color>(
                            Color.fromARGB(255, 103, 80, 164),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditRecipeDetailDialog(
                                isNewRecipe: widget.isNewRecipe,
                                recipe: widget.recipe,
                              );
                            },
                          );
                        },
                        child: Text('Edit Recipe Details',
                            style: GoogleFonts.deliusSwashCaps(
                                fontSize: 15, color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: widget.isNewRecipe
                        ? ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                                  const WidgetStatePropertyAll<Color>(
                                Color.fromARGB(255, 103, 80, 164),
                              ),
                            ),
                            onPressed: () {
                              if (widget.recipe.title.isEmpty ||
                                  widget.recipe.description!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please enter a recipe name and description'),
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditRecipeDetailDialog(
                                      recipe: widget.recipe,
                                      isNewRecipe: widget.isNewRecipe,
                                    );
                                  },
                                );
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Save Recipe',
                                style: GoogleFonts.deliusSwashCaps(
                                    fontSize: 15, color: Colors.white)),
                          )
                        : const Text(''),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
