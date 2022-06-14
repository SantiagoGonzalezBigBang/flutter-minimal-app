import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,    
    IconData? icon,
    VoidCallback? onPressedIcon
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.dmSans(
        color: const Color(0xff161B14)
      ),
      suffixIcon: icon == null ? null : IconButton(
        icon: Icon(icon),
        onPressed: onPressedIcon,
      )
    );
  }

  static InputDecoration searchInputDecoration() {
    return InputDecoration(
      hintText: 'Search....',
      hintStyle: GoogleFonts.dmSans(
        fontWeight: FontWeight.w500,
        fontSize: 13.0,
        color: const Color(0xff000000).withOpacity(0.62)
      ),
      border: InputBorder.none,      
      prefixIcon: const Icon(
        Icons.search,
      ),
    );
  }

}