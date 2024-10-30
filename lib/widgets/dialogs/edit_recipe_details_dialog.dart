import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/widgets/editable_chip_field.dart';
import 'package:recipe_book_ai/widgets/recipe_rating_widget.dart';

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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: RecipeRatingWidget(
                  recipe: widget.recipe,
                  handleRatingChange: (rating) {
                    setState(() {
                      widget.recipe.updateRating(rating);
                    });
                  }),
            ),
            EditableChipField(recipe: widget.recipe),
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
                  widget.recipe.save();
                } else {
                  Provider.of<Recipes>(context, listen: false)
                      .updateRecipe(widget.recipe);
                  widget.recipe.save();
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Save Recipe',
              style: GoogleFonts.deliusSwashCaps(),
            ),
          ),
        ),
      ],
    );
  }
}
