import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/widgets/floating_action_builder.dart';
import 'package:recipe_book_ai/widgets/recipe_list_tile.dart';
import 'package:recipe_book_ai/utils/mock_recipes.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO: Add localstore package functionality

void main() {
  runApp(
    (const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var recipes = Recipes(mockRecipes);

  // handleAddRecipe(Recipe recipe) {
  //   setState(() {
  //     recipes.addRecipe(recipe);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/svg/google-gemini-icon.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      width: 20,
    );
    return ChangeNotifierProvider(
      create: (context) => recipes,
      child: MaterialApp(
          title: 'Recipe Book AI',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: Scaffold(
            floatingActionButton: FloatingActionBuilder(svg: svg),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(225, 220, 59, 119),
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Recipe Book ',
                      style: GoogleFonts.deliusSwashCaps(
                        fontSize: 36,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const Text(
                      'AI',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      child: svg,
                    ),
                  ],
                ),
              ),
            ),
            body: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(tileMode: TileMode.clamp, colors: [
                  Color.fromARGB(225, 220, 59, 119),
                  Color.fromARGB(255, 168, 130, 175),
                ]),
                backgroundBlendMode: BlendMode.src,
              ),
              child: Center(
                heightFactor: 2,
                widthFactor: 5,
                child: ResponsiveLayout(
                  child: Consumer<Recipes>(
                    builder: (context, recipes, child) => Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            return RecipleListTile(
                                recipe: Provider.of<Recipes>(context)
                                    .recipes[index]);
                          }),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
