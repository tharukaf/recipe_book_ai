import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
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
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 270,
                child: ListView.builder(
                  itemCount: widget.ingredientList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipePrepItem(
                        ingredient: widget.ingredientList[index],
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
                                // Provider.of<Recipes>(context, listen: false)
                                //     .addRecipe(widget.recipe);
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

class EditRecipeDetailDialog extends StatefulWidget {
  final Recipe recipe;
  final bool isNewRecipe;

  const EditRecipeDetailDialog({
    super.key,
    required this.recipe,
    required this.isNewRecipe,
  });

  @override
  State<EditRecipeDetailDialog> createState() => _EditRecipeDetailDialogState();
}

class _EditRecipeDetailDialogState extends State<EditRecipeDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Recipe Details', style: GoogleFonts.deliusSwashCaps()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                  width: 700,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: TextEditingController(
                        text: widget.recipe.title,
                      ),
                      maxLength: 80,
                      decoration: InputDecoration(
                        labelText: 'Recipe Name',
                        labelStyle: GoogleFonts.deliusSwashCaps(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 103, 80, 164),
                        ),
                      ),
                      onChanged: (value) {
                        widget.recipe.title = value;
                      },
                    ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                  width: 700,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: TextEditingController(
                          text: widget.recipe.description),
                      onChanged: (value) {
                        widget.recipe.description = value;
                      },
                      maxLength: 200,
                      decoration: InputDecoration(
                        labelText: 'Recipe Description',
                        labelStyle: GoogleFonts.deliusSwashCaps(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 103, 80, 164),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel', style: GoogleFonts.deliusSwashCaps()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Consumer<Recipes>(
          builder: (context, recipes, child) => ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (widget.recipe.title == '' ||
                  widget.recipe.description! == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a recipe name and description'),
                  ),
                );
              } else {
                if (widget.isNewRecipe) {
                  Provider.of<Recipes>(context, listen: false)
                      .addRecipe(widget.recipe);
                } else {
                  Provider.of<Recipes>(context, listen: false)
                      .updateRecipe(widget.recipe);
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(
                'Save Recipe ${Provider.of<Recipes>(context).recipes.length}',
                style: GoogleFonts.deliusSwashCaps()),
          ),
        ),
      ],
    );
  }
}
