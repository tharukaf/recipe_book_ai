import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recipe_book_ai/widgets/add_recipe_screen.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';

class FloatingActionBuilder extends StatelessWidget {
  final void Function(Recipe recipe) handleAddRecipe;
  const FloatingActionBuilder({
    super.key,
    required this.handleAddRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          shape: const CircleBorder(),
          child: const Icon(Icons.edit),
          label: 'Add Recipe Manually',
          backgroundColor: const Color.fromARGB(255, 236, 64, 207),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRecipeScreen(),
              ),
            );
          },
        ),
        SpeedDialChild(
          shape: const CircleBorder(),
          child: const Icon(Icons.camera_alt),
          label: 'Add Recipe with AI',
          backgroundColor: const Color.fromARGB(255, 236, 64, 213),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRecipeScreen(),
              ),
            );
          },
        ),
      ],
      backgroundColor: Colors.pink[400],
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}
