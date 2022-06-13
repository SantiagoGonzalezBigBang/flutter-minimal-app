import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_app/ui/ui.dart';

class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField({
    Key? key, 
    required this.hintText,
    this.obscureText,
    this.textEditingController,
    this.keyboardType,
    this.textInputAction,
    this.onPressedIcon, 
    this.onFieldSubmitted, 
    this.validator,
    this.enabled = true
  }) : super(key: key);

  final String hintText;
  final bool? obscureText;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onPressedIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: enabled,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      obscureText: obscureText ?? false,
      style: GoogleFonts.dmSans(
        fontSize: 16.0,
        color: const Color(0xff161B14)
      ),
      keyboardType: keyboardType,
      decoration: InputDecorations.authInputDecoration(
        hintText: hintText,
        icon: getObscureIcon(),
        onPressedIcon: onPressedIcon
      ),         
    );
  }

  IconData? getObscureIcon() {
    if (obscureText == null) return null;
    return obscureText! ? Icons.visibility_off : Icons.visibility;
  }

}