import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/widgets/floating_action_builder.dart';
import 'package:recipe_book_ai/widgets/recipe_list_tile.dart';

// TODO: Add localstore package functionality
// import 'package:localstore/localstore.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipe Book AI',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          floatingActionButton: const FloatingActionBuilder(),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 176, 39, 146),
            title: Center(
              child: Text(
                'RECIPE BOOK AI',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Center(
            child: ListView.builder(itemBuilder: (context, index) {
              return RecipleListTile(index: index);
            }),
          ),
        ));
  }
}
