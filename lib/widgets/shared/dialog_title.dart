import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        color: const Color(0xff222222),
        fontWeight: FontWeight.w500,
        fontSize: 17.0
      ),
    );
  }
}