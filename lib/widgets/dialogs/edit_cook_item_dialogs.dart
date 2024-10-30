import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/widgets/dialogs/add_cook_item_dialog.dart';
import 'package:recipe_book_ai/widgets/duration_text_field.dart';

void cookItemLongPressDialog(
    BuildContext context, widget, Recipe recipe, handleRemoveCookStep) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Step', style: GoogleFonts.deliusSwashCaps()),
        content: Text('Are you sure you want to delete this step?',
            style: GoogleFonts.deliusSwashCaps()),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
              handleRemoveCookStep(widget.cookingStep);
            },
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              recipe.deleteCookingStep(widget.cookingStep);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void cookItemShortPressDialog(BuildContext context, widget, Recipe recipe,
    duration, handleChangeDuration, removeCookingStep, handleUpdateCookStep) {
  // Edit cooking step when clicked
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Cook Step',
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
                    controller: TextEditingController(
                      text: widget.cookingStep.description,
                    ),
                    maxLength: 150,
                    onChanged: (value) {
                      widget.cookingStep.description = value;
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
                              labelText: 'Hrs',
                              duration: duration['hours'],
                              handleChangeDuration: (value) {
                                duration['hours'] = int.tryParse(value) ?? 0;
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
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                recipe.deleteCookingStep(widget.cookingStep);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (widget.cookingStep.description.isNotEmpty) {
                  Navigator.of(context).pop();
                  widget.cookingStep.duration = Duration(
                    hours: duration['hours'] ?? 0,
                    minutes: duration['mins'] ?? 0,
                    seconds: duration['secs'] ?? 0,
                  );
                  handleUpdateCookStep();
                  handleChangeDuration();
                  recipe.save();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      });
}
