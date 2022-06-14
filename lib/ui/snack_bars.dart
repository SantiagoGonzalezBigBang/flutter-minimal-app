import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SnackBars {

  static SnackBar getNormalSnackBar(String text) {
    return SnackBar(
      content: Text(
        text,
        style: GoogleFonts.dmSans(),
      )
    );
  }

}