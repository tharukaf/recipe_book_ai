import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';
import 'package:recipe_book_ai/utils/titles.dart';
import 'package:recipe_book_ai/widgets/add_new_ingredient.dart';
import 'package:recipe_book_ai/widgets/recipe_prep_items.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe? recipe;
  final bool isNewRecipe;

  const RecipeDetailScreen({
    super.key,
    this.recipe,
    required this.isNewRecipe,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Recipe? recipe;

  handleAddNewIngredient(Ingredient ingredient) {
    setState(() {
      recipe!.ingredients!.add(ingredient);
    });
  }

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
  }

  void changeCheckboxValue(int index, bool? value) {
    setState(() {
      recipe!.ingredients![index].isDone = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 2;
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        floatingActionButton: NewIngredientDialog(
          ingredientIndex: recipe!.ingredients!.length,
          recipe: recipe!,
          handleAddNewIngredient: handleAddNewIngredient,
        ),
        appBar: AppBar(
          title: Text(recipe!.title),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.shopping_cart),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.soup_kitchen),
                text: titles[1],
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          RecipePrepItems(
              changeCheckboxValue: changeCheckboxValue,
              ingredientList: recipe!.ingredients!),
          RecipeCookItems(cookingSteps: recipe!.cookingSteps!),
        ]),
      ),
    );
  }
}

class RecipeCookItems extends StatefulWidget {
  final List<CookingStep> cookingSteps;

  RecipeCookItems({
    super.key,
    required this.cookingSteps,
  });

  @override
  State<RecipeCookItems> createState() => _RecipeCookItemsState();
}

class _RecipeCookItemsState extends State<RecipeCookItems> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: ListView.builder(
            itemCount: widget.cookingSteps.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipeCookItem(
                cookingStep: widget.cookingSteps[index],
              );
            },
          )),
    );
  }
}

class RecipeCookItem extends StatefulWidget {
  final CookingStep cookingStep;

  const RecipeCookItem({
    super.key,
    required this.cookingStep,
  });

  @override
  State<RecipeCookItem> createState() => _RecipeCookItemState();
}

class _RecipeCookItemState extends State<RecipeCookItem> {
  int countdown = 0;
  bool buttonPressed = false;

  void playSound() async {
    await FlutterPlatformAlert.playAlertSound();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    countdown = widget.cookingStep.duration.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: 30,
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
                      fontSize: 60,
                      color: const Color.fromARGB(104, 74, 20, 140),
                    ),
                  ),
                ),
              ),
              Text(
                // 'lorem ipsum lorem  lorem ipsum lorem  lorem ipsum lorem lorem ipsum lorem  lorem ipsum lorem ',
                widget.cookingStep.description.endsWith('.')
                    ? widget.cookingStep.description
                        .substring(0, widget.cookingStep.description.length - 1)
                    : widget.cookingStep.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: true,

                style: GoogleFonts.deliusSwashCaps(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              widget.cookingStep.duration > Duration.zero
                  ? Row(
                      children: getDurationString(widget.cookingStep.duration),
                    )
                  : const Text(''),
            ],
          ),
          widget.cookingStep.duration.inSeconds > 0
              ? Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        if (buttonPressed) {
                          return;
                        }
                        setState(() {
                          buttonPressed = true;
                        });
                        Timer.periodic(const Duration(seconds: 1), (timer) {
                          mounted
                              ? setState(() {
                                  countdown =
                                      widget.cookingStep.duration.inSeconds -
                                          timer.tick;
                                })
                              : timer.cancel();
                          if (timer.tick ==
                              widget.cookingStep.duration.inSeconds) {
                            timer.cancel();
                            playSound();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Timer Finished'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            setState(() {
                              buttonPressed = false;
                              countdown = widget.cookingStep.duration.inSeconds;
                            });
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 3),
                        child: Column(
                          children: [
                            const Text('Start Timer'),
                            Text(countdown % 60 == 0
                                ? '${countdown ~/ 60}:00'
                                : '${countdown ~/ 60}:${countdown % 60}'),
                          ],
                        ),
                      )),
                )
              : const Text(''),
        ],
      ),
    );
  }
}

// Gets the cooking step duration time as a Text widget
List<Widget> getDurationString(Duration duration) {
  String durationString = '';
  if (duration.inHours > 0) {
    durationString +=
        '${duration.inHours}${duration.inHours == 1 ? 'hr' : 'hrs'} ';
  } else if (duration.inMinutes > 0) {
    durationString +=
        '${duration.inMinutes}${duration.inMinutes == 1 ? 'min' : 'mins'} ';
  } else if (duration.inSeconds > 0) {
    durationString += '${duration.inSeconds}s ';
  }

  return [
    Text(
      ' for ',
      style: GoogleFonts.deliusSwashCaps(
          color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(186, 194, 87, 212),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(durationString,
          style: GoogleFonts.deliusSwashCaps(
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          )),
    )
  ];
}
