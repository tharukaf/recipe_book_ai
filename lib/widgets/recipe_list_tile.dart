import 'package:flutter/material.dart';
import 'package:recipe_book_ai/widgets/recipe_detail_screen.dart';

class RecipleListTile extends StatelessWidget {
  final int index;
  const RecipleListTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(colors: [
          Colors.purple[100]!,
          Colors.purple[50]!,
        ]),
      ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          'Item $index',
          style: const TextStyle(
              color: Color.fromARGB(151, 0, 0, 0),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Description of Item $index',
          style: const TextStyle(
              color: Color.fromARGB(127, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
