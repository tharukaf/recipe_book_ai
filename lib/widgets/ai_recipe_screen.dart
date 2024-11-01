import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddAIRecipeScreen extends StatefulWidget {
  const AddAIRecipeScreen({super.key});

  @override
  State<AddAIRecipeScreen> createState() => _AddAIRecipeScreenState();
}

class _AddAIRecipeScreenState extends State<AddAIRecipeScreen> {
  String url = '';
  bool isLoading = false;
  Recipe recipe = Recipe.empty();

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
            color: const Color.fromARGB(246, 255, 192, 239),
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
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              recipe = await createRecipe(url);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<http.Response> addRecipe(String recipeURL) async {
  try {
    return await http.post(
      Uri.parse('http://localhost:3000/recipe'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'recipeURL': recipeURL,
      }),
    );
  } catch (e) {
    log(e.toString());
    return Future.error(e);
  }
}

Future<Recipe> createRecipe(String recipeURL) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/recipe'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'recipeURL': recipeURL,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(response.body);
    return Recipe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create recipe.');
  }
}
