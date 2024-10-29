import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/utils/dropdown_unit_items.dart';

class NewPrepItemDialog extends StatefulWidget {
  final Recipe recipe;
  final void Function(Ingredient) handleAddNewIngredient;
  final int ingredientIndex;

  const NewPrepItemDialog({
    super.key,
    required this.ingredientIndex,
    required this.recipe,
    required this.handleAddNewIngredient,
  });

  @override
  State<NewPrepItemDialog> createState() => _NewPrepItemDialogState();
}

class _NewPrepItemDialogState extends State<NewPrepItemDialog> {
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
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      items: dropdownMenuItems
                          .map((DropdownMenuItem<dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item.value.toString(),
                          child: item.child,
                        );
                      }).toList(),
                      onChanged: (value) {
                        ingredient?.unit = value!;
                      },
                      value: ingredient?.unit,
                    ),
                  ),
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
