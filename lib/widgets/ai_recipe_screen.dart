import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:typewritertext/typewritertext.dart';

// ignore: must_be_immutable
class AddAIRecipeScreen extends StatefulWidget {
  const AddAIRecipeScreen({super.key});

  @override
  State<AddAIRecipeScreen> createState() => _AddAIRecipeScreenState();
}

class _AddAIRecipeScreenState extends State<AddAIRecipeScreen> {
  String url = '';
  bool isLoading = false;
  bool isButtonClicked = false;
  Recipe recipe = Recipe.empty();
  String recipeText = '';

  @override
  void dispose() {
    isButtonClicked = false;
    super.dispose();
  }

  void handleChangeRecipeText(String text) {
    setState(() {
      recipeText = text;
    });
  }

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
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(246, 255, 192, 239),
                Color.fromARGB(246, 199, 107, 178),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Recipe URL Input
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 49,
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
                ),

                // Add Recipe Button
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                              isButtonClicked = true;
                            });
                            try {
                              recipe = await createRecipe(
                                  url, handleChangeRecipeText);
                              if (recipe.title == '') {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to create recipe.'),
                                  ),
                                );
                                return;
                              }
                              recipe.save();

                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Recipe added successfully!'),
                                ),
                              );
                            } finally {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
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
                // Recipe Text output
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 235, 251),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: !isButtonClicked
                            ? Center(
                                child: Text(
                                  'Waiting for recipe url...',
                                  style: GoogleFonts.jura(
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : BuildRecipeText(recipeText: recipeText)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildRecipeText extends StatelessWidget {
  final String recipeText;
  const BuildRecipeText({super.key, required this.recipeText});

  @override
  Widget build(BuildContext context) {
    // return TypeWriter(
    //   controller: TypeWriterController(
    //     text: recipeText,
    //     duration: const Duration(microseconds: 100),
    //   ),
    //   builder: (context, value) {
    //     // print(value.text);
    //     return Text(
    //       value.text,
    //       style: GoogleFonts.jura(
    //         color: Colors.grey[700],
    //       ),
    //     );
    //   },
    // );
    return SingleChildScrollView(
      child: Text(
        recipeText,
        style: GoogleFonts.jura(
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

Future<Recipe> createRecipe(String recipeURL, handleChangeText) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['SERVER_ADDRESS']}recipe'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'recipeURL': recipeURL,
      }),
    );

    if (response.statusCode == 200) {
      handleChangeText(response.body);

      return Recipe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      log('Server error: ${response.statusCode}');
      return Recipe.empty();
    }
  } catch (e) {
    log('Error creating recipe: ${e.toString()}');
    return Recipe.empty();
  }
}
