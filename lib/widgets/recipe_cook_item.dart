import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/utils/duration.dart';
import 'package:recipe_book_ai/utils/recipe_models.dart';

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
