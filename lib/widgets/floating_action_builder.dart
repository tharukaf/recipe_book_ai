import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recipe_book_ai/widgets/add_recipe_screen.dart';
import 'package:recipe_book_ai/widgets/ai_recipe_screen.dart';
// import 'package:recipe_book_ai/widgets/recipe_detail_screen.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';

class FloatingActionBuilder extends StatelessWidget {
  final Widget svg;
  const FloatingActionBuilder({
    super.key,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // icon: Icons.add_a_photo,
      overlayColor: Colors.black,
      activeBackgroundColor: Colors.grey[200],
      animatedIcon: AnimatedIcons.add_event,
      spaceBetweenChildren: 10,
      children: [
        SpeedDialChild(
          shape: const CircleBorder(),
          child: const Icon(Icons.edit),
          label: 'Add Recipe Manually',
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
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
          child: svg,
          label: 'Add Recipe with AI',
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAIRecipeScreen(),
              ),
            );
          },
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 255, 198, 217),
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}
