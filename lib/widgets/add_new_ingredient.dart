import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/dropdown_unit_items.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';

class NewIngredientDialog extends StatelessWidget {
  final Ingredient ingredient = Ingredient(
    id: 0,
    name: '',
    quantity: 0,
    unit: '',
    isDone: false,
  );
  final Recipe recipe;
  final void Function(Ingredient) handleAddNewIngredient;
  final int ingredientIndex;

  NewIngredientDialog({
    super.key,
    required this.ingredientIndex,
    required this.recipe,
    required this.handleAddNewIngredient,
  });

  @override
  Widget build(BuildContext context) {
    ingredient.id = ingredientIndex;

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
                        ingredient.quantity = double.parse(value);
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
                handleAddNewIngredient(ingredient);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
