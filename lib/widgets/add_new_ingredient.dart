import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/utils/dropdown_unit_items.dart';

import 'package:recipe_book_ai/widgets/duration_text_field.dart';
// import 'package:textfield_tags/textfield_tags.dart';

class NewIngredientDialog extends StatefulWidget {
  final Recipe recipe;
  final void Function(Ingredient) handleAddNewIngredient;
  final int ingredientIndex;

  const NewIngredientDialog({
    super.key,
    required this.ingredientIndex,
    required this.recipe,
    required this.handleAddNewIngredient,
  });

  @override
  State<NewIngredientDialog> createState() => _NewIngredientDialogState();
}

class _NewIngredientDialogState extends State<NewIngredientDialog> {
  Ingredient? ingredient;

  @override
  Widget build(BuildContext context) {
    ingredient = Ingredient(
      id: 0,
      name: '',
      quantity: 0,
      unit: '',
      isDone: false,
    );
    ingredient?.id = widget.ingredientIndex;

    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: const Color(0xFFFFFFFF),
      shape: const CircleBorder(),
      onPressed: () => _dialogBuilder(context),
      child: const Icon(Icons.add),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Ingredient',
            style: GoogleFonts.deliusSwashCaps(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(
                  onChanged: (value) {
                    ingredient?.name = value;
                  },
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.deliusSwashCaps(),
                    labelText: 'Enter the ingredient',
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        onChanged: (value) {
                          ingredient?.quantity = double.tryParse(value) ?? 0;
                        },
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          height: 2,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.deliusSwashCaps(),
                          labelText: 'Quantity',
                        ),
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: ingredient?.unit,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    onChanged: (value) {
                      ingredient?.unit = value.toString();
                    },
                    items: dropdownMenuItems,
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (ingredient!.name.isNotEmpty && ingredient!.quantity > 0) {
                  widget.handleAddNewIngredient(ingredient!);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class NewCookingStepDialog extends StatefulWidget {
  final Recipe recipe;
  final void Function(CookingStep) handleAddNewCookStep;
  final int stepIndex;

  const NewCookingStepDialog({
    super.key,
    required this.stepIndex,
    required this.recipe,
    required this.handleAddNewCookStep,
  });

  @override
  State<NewCookingStepDialog> createState() => _NewCookingStepDialogState();
}

final boxDeco = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      const Color.fromARGB(255, 255, 192, 218),
      const Color.fromARGB(255, 250, 181, 181).withOpacity(0.5),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  border: Border.all(
    color: Colors.black38,
  ),
  borderRadius: BorderRadius.circular(10),
);

class _NewCookingStepDialogState extends State<NewCookingStepDialog> {
  final TextEditingController stepController = TextEditingController();

  CookingStep? cookingStep;
  var duration = {
    'hrs': 0,
    'mins': 0,
    'secs': 0,
  };

  @override
  Widget build(BuildContext context) {
    duration = {
      'hrs': 0,
      'mins': 0,
      'secs': 0,
    };
    cookingStep = CookingStep(
      stepNumber: 0,
      description: '',
      duration: Duration.zero,
    );
    cookingStep?.stepNumber = widget.stepIndex + 1;
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: const Color(0xFFFFFFFF),
      shape: const CircleBorder(),
      onPressed: () => _dialogBuilder(context),
      child: const Icon(Icons.add),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cook Step Details',
            style: GoogleFonts.deliusSwashCaps(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width < 600 ? 200 : 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: boxDeco,
                  child: TextField(
                    maxLength: 150,
                    onChanged: (value) {
                      cookingStep?.description = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Instructions',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: boxDeco,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            'Duration',
                            style: GoogleFonts.deliusSwashCaps(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            DurationTextField(
                              duration: duration['hrs'],
                              labelText: 'Hrs',
                              handleChangeDuration: (value) {
                                duration['hrs'] = int.tryParse(value) ?? 0;
                              },
                            ),
                            DurationTextField(
                              duration: duration['mins'],
                              labelText: 'Mins',
                              handleChangeDuration: (value) {
                                duration['mins'] = int.tryParse(value) ?? 0;
                              },
                            ),
                            DurationTextField(
                              duration: duration['secs'],
                              labelText: 'Secs',
                              handleChangeDuration: (value) {
                                duration['secs'] = int.tryParse(value) ?? 0;
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // ) TODO: Add tags https://pub.dev/packages/textfield_tags
                // TODO: Add serving size input
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (cookingStep!.description.isNotEmpty) {
                  Navigator.of(context).pop();
                  cookingStep!.duration = Duration(
                    hours: duration['hrs'] ?? 0,
                    minutes: duration['mins'] ?? 0,
                    seconds: duration['secs'] ?? 0,
                  );
                  widget.handleAddNewCookStep(cookingStep!);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
