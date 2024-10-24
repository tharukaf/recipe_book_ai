import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/cooking_step.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/utils/dropdown_unit_items.dart';
import 'package:recipe_book_ai/widgets/clickable_item.dart';

class RecipePrepItem extends StatelessWidget {
  const RecipePrepItem({
    super.key,
    required this.recipe,
    required this.handleChangePrepItem,
    required this.handleRemovePrepItem,
    required this.index,
    required this.ingredient,
    required this.changeCheckboxValue,
  });

  final Recipe recipe;
  final void Function(int, Ingredient) handleChangePrepItem;
  final void Function(int) handleRemovePrepItem;
  final int index;
  final Ingredient ingredient;
  final void Function(int, bool?) changeCheckboxValue;

  Color changeIngredientBackground() {
    if (ingredient.isDone) {
      return const Color.fromARGB(111, 76, 58, 78);
    } else {
      if (index.isOdd) {
        return const Color.fromARGB(52, 176, 92, 189);
      } else {
        return const Color.fromARGB(36, 176, 92, 189);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClickableItem(
      onPressed: () {
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
                      DropdownButton(
                        value: ingredient.unit,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        onChanged: (value) {
                          ingredient.unit = value.toString();
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
                    handleRemovePrepItem(index);
                    Navigator.of(context).pop();
                  },
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
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
                    }
                  },
                  child: const Text('Edit'),
                ),
              ],
            );
          },
        );
      },
      onLongPress: () {
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
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    handleRemovePrepItem(index);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: changeIngredientBackground(),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(97, 206, 147, 216),
            ),
          ),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: ingredient.isDone,
                onChanged: (bool? value) {
                  changeCheckboxValue(index, value);
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ingredient.isDone
                      ? const Color.fromARGB(111, 76, 58, 78)
                      : const Color.fromARGB(246, 255, 192, 239),
                ),
                child: Text(
                  '${ingredient.quantity % 1 == 0 ? ingredient.quantity.floor() : ingredient.quantity} ${ingredient.unit}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6),
                child: Text(
                  ingredient.name,
                  style: GoogleFonts.deliusSwashCaps(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: ingredient.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
