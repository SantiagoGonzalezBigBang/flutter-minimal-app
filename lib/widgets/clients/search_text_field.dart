import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:minimal_app/ui/ui.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key, 
    this.onChanged, 
    this.controller, 
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff1F1D2B).withOpacity(0.61),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(68.0)
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.dmSans(
          fontWeight: FontWeight.w500,
          color: const Color(0xff000000)
        ),
        decoration: InputDecorations.searchInputDecoration()
      ),
    );
  }
}