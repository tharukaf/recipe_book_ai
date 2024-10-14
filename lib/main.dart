import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
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
        title: 'My Recipe Book',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow[900],
            title: Center(
              child: Text(
                'MY RECIPE BOOK',
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

class RecipleListTile extends StatelessWidget {
  final int index;
  const RecipleListTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(index: index),
            ),
          );
        },
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        contentPadding: EdgeInsets.all(10),
        title: Text(
          'Item $index',
          style: const TextStyle(
              color: Colors.black38, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Description of Item $index',
          style: const TextStyle(
              color: Colors.black38,
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final int index;
  const RecipeDetailScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item $index'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Item $index',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Description of Item $index',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
