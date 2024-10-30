import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/widgets/recipe_detail_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/widgets/recipe_rating_widget.dart';

class RecipleListTile extends StatelessWidget {
  final Recipe recipe;
  const RecipleListTile({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(
              recipe: recipe,
              isNewRecipe: false,
            ),
          ),
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Recipe?',
                style: GoogleFonts.deliusSwashCaps(fontSize: 20)),
            content: Text('Are you sure you want to delete this recipe?',
                style: GoogleFonts.deliusSwashCaps()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<Recipes>(context, listen: false)
                      .removeRecipe(recipe);
                  recipe.delete();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          gradient: LinearGradient(colors: [
            Colors.purple[100]!,
            Colors.purple[50]!,
          ]),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      recipe.title,
                      style: GoogleFonts.deliusSwashCaps(
                          color: const Color.fromARGB(151, 0, 0, 0),
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      recipe.description!,
                      style: const TextStyle(
                          color: Color.fromARGB(127, 0, 0, 0),
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: RecipeRatingWidget(
                      recipe: recipe,
                    )),
              ],
            ),
            const Spacer(),
            SizedBox(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: recipe.tags.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var tag in recipe.tags.take(4))
                            Container(
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 168, 130, 175),
                                ),
                                color: Colors.white,
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.deliusSwashCaps(
                                  color: Colors.black87,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      )
                    : const Text(''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
