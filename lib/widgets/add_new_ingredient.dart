import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/dropdown_unit_items.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:duration_picker/duration_picker.dart';

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
  final TextEditingController unitController = TextEditingController();

  final Ingredient ingredient = Ingredient(
    id: 0,
    name: '',
    quantity: 0,
    unit: '',
    isDone: false,
  );

  @override
  Widget build(BuildContext context) {
    ingredient.id = widget.ingredientIndex;

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
          title: const Text('Add Ingredient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  ingredient.name = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter the ingredient',
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        ingredient.quantity = double.tryParse(value) ?? 0;
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        height: 2,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: ingredient.unit,
                    onChanged: (value) => ingredient.unit = value.toString(),
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
                if (ingredient.name.isNotEmpty && ingredient.quantity > 0) {
                  widget.handleAddNewIngredient(ingredient);
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

  NewCookingStepDialog({
    super.key,
    required this.stepIndex,
    required this.recipe,
    required this.handleAddNewCookStep,
  });

  @override
  State<NewCookingStepDialog> createState() => _NewCookingStepDialogState();
}

class _NewCookingStepDialogState extends State<NewCookingStepDialog> {
  final TextEditingController stepController = TextEditingController();

  CookingStep cookingStep = CookingStep(
    stepNumber: 0,
    description: '',
    duration: Duration(hours: 0, minutes: 0),
  );

  @override
  Widget build(BuildContext context) {
    cookingStep.stepNumber = widget.stepIndex;
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
          title: const Text('Add Cook Step'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  cookingStep.description = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Instructions',
                ),
              ),
              DurationPicker(
                duration: cookingStep.duration,
                onChange: (val) {
                  setState(() {
                    cookingStep.duration = val;
                  });
                },
              ),
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
                if (cookingStep.description.isNotEmpty) {
                  widget.handleAddNewCookStep(cookingStep);
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
