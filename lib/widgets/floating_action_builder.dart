import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/widgets/add_recipe_screen.dart';
import 'package:recipe_book_ai/widgets/recipe_detail_screen.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class FloatingActionBuilder extends StatelessWidget {
  final Widget svg;
  const FloatingActionBuilder({
    super.key,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // icon: Icons.add_a_photo,
      overlayColor: Colors.black,
      activeBackgroundColor: Colors.grey[200],
      animatedIcon: AnimatedIcons.add_event,
      spaceBetweenChildren: 10,
      children: [
        SpeedDialChild(
          shape: const CircleBorder(),
          child: const Icon(Icons.edit),
          label: 'Add Recipe Manually',
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddRecipeScreen(),
              ),
            );
          },
        ),
        SpeedDialChild(
          shape: const CircleBorder(),
          child: svg,
          label: 'Add Recipe with AI',
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAIRecipeScreen(),
              ),
            );
          },
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 255, 198, 217),
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}

// ignore: must_be_immutable
class AddAIRecipeScreen extends StatelessWidget {
  AddAIRecipeScreen({super.key});

  String url = '';
  final Recipe recipe = Recipe.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add AI Recipe',
          style: GoogleFonts.deliusSwashCaps(),
        ),
      ),
      body: ResponsiveLayout(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextField(
                    onChanged: (value) => url = value,
                    decoration: InputDecoration(
                      labelText: 'Recipe URL',
                      labelStyle: GoogleFonts.deliusSwashCaps(
                        color: Colors.black,
                      ),
                      hintText: 'Enter the URL of the recipe',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RecipeDetailScreen(
                      //       isNewRecipe: true,
                      //       recipe: recipe,
                      //     ),
                      //   ),
                      // );
                      final gemini = Gemini.instance;

                      gemini.streamGenerateContent(url).listen((value) {
                        print(value.output);
                      }).onError(
                        (e) {
                          log('streamGenerateContent exception', error: e);
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Add Recipe',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
