import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_ai/models/ingredient.dart';
import 'package:recipe_book_ai/utils/duration.dart';

class TimerButton extends StatelessWidget {
  const TimerButton(
      {super.key,
      required this.cookingStep,
      required this.handleTimerTick,
      required this.resetTimer,
      required this.countdown,
      required this.buttonPressed,
      required this.handleButtonPressed,
      required this.mounted});

  final CookingStep cookingStep;
  final Function(Timer) handleTimerTick;
  final Function() resetTimer;
  final int countdown;
  final Function(bool) handleButtonPressed;
  final bool buttonPressed;
  final bool mounted;

  void playSound() async {
    await FlutterPlatformAlert.playAlertSound();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton(
        onPressed: () {
          if (buttonPressed) {
            return;
          }
          handleButtonPressed(true);
          Timer.periodic(const Duration(seconds: 1), (timer) {
            mounted ? handleTimerTick(timer) : timer.cancel();
            if (!mounted) {
              timer.cancel();
            }
            if (timer.tick == cookingStep.duration.inSeconds) {
              timer.cancel();
              playSound();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Timer Finished',
                        style: GoogleFonts.deliusSwashCaps()),
                    content: Text(
                        'The timer for cooking step ${cookingStep.stepNumber} is done!',
                        style: GoogleFonts.deliusSwashCaps()),
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
              resetTimer();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          child: Column(
            children: [
              const Text('Start Timer'),
              Text(getTimerText(countdown)),
            ],
          ),
        ),
      ),
    );
  }
}
