import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/utils/titles.dart';

class RecipePrepItem extends StatelessWidget {
  const RecipePrepItem({
    super.key,
    required this.oddItemColor,
    required this.evenItemColor,
    required this.list,
    required this.index,
    required this.changeCheckboxValue,
  });

  final Color oddItemColor;
  final Color evenItemColor;
  final List<Ingredient> list;
  final int index;
  final void Function(int, bool?) changeCheckboxValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index.isOdd ? oddItemColor : evenItemColor,
          border: Border.all(
            color: index.isOdd ? oddItemColor : evenItemColor,
            width: 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: list.contains('${titles[0]} $index'),
              onChanged: (bool? value) {
                changeCheckboxValue(index, value);
              },
            ),
            Text(
              list.contains('${titles[0]} $index')
                  ? '${titles[0]} $index'
                  : '${titles[0]} $index',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: list.contains('${titles[0]} $index')
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
