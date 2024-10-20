import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recipe_book_ai/widgets/add_recipe_screen.dart';

class FloatingActionBuilder extends StatelessWidget {
  const FloatingActionBuilder({
    super.key,
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
                builder: (context) => const AddRecipeScreen(),
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
                builder: (context) => const AddRecipeScreen(),
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
