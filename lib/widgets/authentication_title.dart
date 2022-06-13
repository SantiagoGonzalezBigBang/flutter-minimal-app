import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AuthenticationTitle extends StatelessWidget {
  const AuthenticationTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'LOG IN',
      textAlign: TextAlign.center,
      style: GoogleFonts.dmSans(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        letterSpacing: 2.5,
      ),
    );
  }
}