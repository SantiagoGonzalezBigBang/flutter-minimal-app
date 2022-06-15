import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key, 
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSmall = false,
    this.isOnlyText = false,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isSmall;
  final bool isOnlyText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isOnlyText ? Colors.transparent : const Color(0xff0D1111),              
        minimumSize: const Size(
          double.infinity, 
          5.0
        ),
        padding: EdgeInsets.symmetric(
          vertical: isSmall ? 10.0 : 20.0
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34.0)
        ),
        elevation: isOnlyText ? 0.0 : 10.0
      ),
      child: !isLoading ? Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          color: isOnlyText ? const Color(0xff080816).withOpacity(0.38) : Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          letterSpacing: 0.5
        ),
      ) : FadeIn(
        child: SizedBox(
          height: 18.5,
          width: 18.5,
          child: LoadingIndicator(
            indicatorType: Indicator.lineScaleParty,
            colors: [
              isOnlyText ? const Color(0xff080816).withOpacity(0.38) : Colors.white
            ],          
          ),
        )
      ),
    );
  }
}