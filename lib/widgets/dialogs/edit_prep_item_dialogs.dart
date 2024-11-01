import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/utils/dropdown_unit_items.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void prepItemLongPressDialog(
  Recipe recipe,
  context,
  handleRemovePrepItem,
  index,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Delete Ingredient',
          style: GoogleFonts.deliusSwashCaps(),
        ),
        content: Text('Are you sure you want to delete this ingredient?',
            style: GoogleFonts.deliusSwashCaps()),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              handleRemovePrepItem(recipe.ingredients[index]);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void prepItemShortPressDialog(
  Recipe recipe,
  context,
  ingredient,
  handleRemovePrepItem,
  handleChangePrepItem,
  index,
) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Edit Ingredient',
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
                maxLength: 50,
                controller: TextEditingController(text: ingredient.name),
                onChanged: (value) {
                  ingredient.name = value;
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
                      controller: TextEditingController(
                          text: ingredient.quantity.toString()),
                      onChanged: (value) {
                        ingredient.quantity = double.tryParse(value) ?? 0;
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
                    hint: const Text('Unit'),
                    items:
                        dropdownMenuItems.map((DropdownMenuItem<dynamic> item) {
                      return DropdownMenuItem<String>(
                        value: item.value.toString(),
                        child: item.child,
                      );
                    }).toList(),
                    onChanged: (value) {
                      ingredient.unit = value!;
                    },
                    value: ingredient.unit,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              handleRemovePrepItem(ingredient);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (ingredient.name.isNotEmpty && ingredient.quantity > 0) {
                Navigator.of(context).pop();
                handleChangePrepItem(index, ingredient);
                recipe.save();
              }
            },
            child: const Text('Edit'),
          ),
        ],
      );
    },
  );
}
