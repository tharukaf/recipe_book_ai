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

String getTimerText(int countdown) {
  print(countdown);
  if (countdown > 3600) {
    return '${getZeroPrefix(countdown ~/ 3600)}:${getZeroPrefix((countdown % 3600) ~/ 60)}:${getZeroPrefix(countdown % 60)}';
  } else if (countdown > 60) {
    return '${getZeroPrefix(countdown ~/ 60)}:${getZeroPrefix(countdown % 60)}';
  } else {
    return '00:${getZeroPrefix(countdown)}';
  }
}

String getZeroPrefix(int value) {
  return value < 10 ? '0$value' : value.toString();
}
