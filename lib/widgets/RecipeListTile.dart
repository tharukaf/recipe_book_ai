import 'package:flutter/material.dart';
import 'package:recipe_book_ai/widgets/RecipeDetailScreen.dart';

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
        contentPadding: const EdgeInsets.all(10),
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
