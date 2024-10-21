import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
