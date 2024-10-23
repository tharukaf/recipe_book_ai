import 'package:flutter/material.dart';

class DurationTextField extends StatelessWidget {
  final String? labelText;
  final void Function(String)? handleChangeDuration;

  const DurationTextField({
    super.key,
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
