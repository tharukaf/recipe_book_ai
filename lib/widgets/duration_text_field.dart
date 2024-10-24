import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DurationTextField extends StatelessWidget {
  int? duration = 0;
  final String? labelText;
  final void Function(String)? handleChangeDuration;

  DurationTextField({
    super.key,
    this.duration,
    required this.labelText,
    required this.handleChangeDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: SizedBox(
        width: 50,
        child: TextField(
          controller: TextEditingController(
            text: duration.toString(),
          ),
          keyboardType: TextInputType.number,
          onChanged: handleChangeDuration,
          decoration: InputDecoration(
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
