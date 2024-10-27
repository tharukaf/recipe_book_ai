import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/utils/duration.dart';
import 'package:recipe_book_ai/widgets/add_new_ingredient.dart';
import 'package:recipe_book_ai/widgets/clickable_item.dart';
import 'package:recipe_book_ai/widgets/duration_text_field.dart';
import 'package:recipe_book_ai/widgets/timer_button.dart';

class RecipeCookItem extends StatefulWidget {
  final CookingStep cookingStep;
  final Function(CookingStep) handleAddNewCookStep;
  final Recipe recipe;
  final Function(CookingStep) removeCookingStep;

  const RecipeCookItem({
    super.key,
    required this.recipe,
    required this.cookingStep,
    required this.handleAddNewCookStep,
    required this.removeCookingStep,
  });

  @override
  State<RecipeCookItem> createState() => _RecipeCookItemState();
}

class _RecipeCookItemState extends State<RecipeCookItem> {
  int countdown = 0;
  final Map<String, int> duration = {
    'hours': 0,
    'mins': 0,
    'secs': 0,
  };
  bool buttonPressed = false;

  @override
  void initState() {
    countdown = widget.cookingStep.duration.inSeconds;
    super.initState();
  }

  @override
  void dispose() {
    countdown = 0;
    super.dispose();
  }

  void handleTimerTick(Timer timer) {
    mounted
        ? setState(() {
            countdown = widget.cookingStep.duration.inSeconds - timer.tick;
          })
        : timer.cancel();
  }

  // Reset timer to initial value
  void resetTimer() {
    setState(() {
      buttonPressed = false;
      countdown = widget.cookingStep.duration.inSeconds;
    });
  }

  // Change duration of cooking step
  void handleChangeDuration() {
    setState(() {
      countdown = widget.cookingStep.duration.inSeconds;
    });
  }

  // Registers if the button is pressed for the first time
  void handleButtonPressed(bool value) {
    setState(() {
      buttonPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    duration['hours'] = widget.cookingStep.duration.inHours;
    duration['mins'] = widget.cookingStep.duration.inMinutes.remainder(60);
    duration['secs'] = widget.cookingStep.duration.inSeconds.remainder(60);
    return ClickableItem(
      onPressed: () {
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  DurationTextField(
                                    labelText: 'Hrs',
                                    duration: duration['hours'],
                                    handleChangeDuration: (value) {
                                      duration['hours'] =
                                          int.tryParse(value) ?? 0;
                                    },
                                  ),
                                  DurationTextField(
                                    duration: duration['mins'],
                                    labelText: 'Mins',
                                    handleChangeDuration: (value) {
                                      duration['mins'] =
                                          int.tryParse(value) ?? 0;
                                    },
                                  ),
                                  DurationTextField(
                                    duration: duration['secs'],
                                    labelText: 'Secs',
                                    handleChangeDuration: (value) {
                                      duration['secs'] =
                                          int.tryParse(value) ?? 0;
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
                      widget.removeCookingStep(widget.cookingStep);
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
                        setState(() {
                          Provider.of<Recipes>(context, listen: false)
                              .getRecipeById(widget.recipe.id)
                              .updateCookingStep(widget.cookingStep);
                        });
                        handleChangeDuration();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            });
      },
      onLongPress: () {
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
                    widget.removeCookingStep(widget.cookingStep);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(97, 206, 147, 216),
          ),
        ),
        margin: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  constraints: const BoxConstraints.tightFor(
                    height: 65,
                    width: 35,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.cookingStep.stepNumber.toString(),
                      style: GoogleFonts.pacifico(
                        fontSize: (widget.cookingStep.stepNumber > 99
                            ? 30
                            : (widget.cookingStep.stepNumber > 9 ? 40 : 60)),
                        letterSpacing: -5,
                        color: const Color.fromARGB(104, 74, 20, 140),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.cookingStep.description.endsWith('.')
                      ? widget.cookingStep.description.substring(
                          0, widget.cookingStep.description.length - 1)
                      : widget.cookingStep.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: false,
                  style: GoogleFonts.deliusSwashCaps(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                widget.cookingStep.duration > Duration.zero
                    ? Row(
                        children:
                            getDurationString(widget.cookingStep.duration),
                      )
                    : const Text(''),
              ],
            ),
            widget.cookingStep.duration.inSeconds > 0
                ? TimerButton(
                    cookingStep: widget.cookingStep,
                    handleTimerTick: handleTimerTick,
                    resetTimer: resetTimer,
                    countdown: countdown,
                    buttonPressed: buttonPressed,
                    handleButtonPressed: handleButtonPressed,
                    mounted: mounted,
                  )
                : const Text(''),
          ],
        ),
      ),
    );
  }
}
