import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstore/localstore.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/widgets/dashboard.dart';
import 'package:recipe_book_ai/widgets/floating_action_builder.dart';
// import 'package:recipe_book_ai/utils/mock_recipes.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:localstore/localstore.dart';

// TODO: Add localstore package functionality
// TODO: Add AI recipe addition functionality

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
  final recipes = Recipes.empty();
  final _db = Localstore.getInstance(useSupportDir: true);
  StreamSubscription<Map<String, dynamic>>? _subscription;
  // final _items = <String, Todo>{};

  // save each recipe to localstore
  // void saveRecipes() {
  //   for (var recipe in mockRecipes) {
  //     _db.collection('recipes').doc(recipe.id).set(recipe.toMap());
  //   }
  // }
  //Call the saveRecipes function in the initState method of the _MyAppState class

  @override
  void initState() {
    _subscription = _db.collection('recipes').stream.listen((event) {
      setState(() {
        final item = Recipe.fromMap(event);
        // recipes.putIfAbsent(item.id, () => item);
        recipes.addRecipe(item);
      });
    });
    if (kIsWeb) _db.collection('recipes').stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => recipes,
      child: MaterialApp(
          title: 'Recipe Book AI',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: const MainScreen()),
    );
  }

  @override
  void dispose() {
    if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String assetName = 'assets/svg/google-gemini-icon.svg';
  late Widget svg;

  @override
  void initState() {
    svg = SvgPicture.asset(
      assetName,
      width: 20,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(tileMode: TileMode.clamp, colors: [
            Color.fromARGB(225, 220, 59, 119),
            Color.fromARGB(255, 168, 130, 175),
          ]),
          backgroundBlendMode: BlendMode.src,
        ),
        child: Center(
          heightFactor: 2,
          widthFactor: 5,
          child: Dashboard(),
        ),
      ),
    );
  }
}
