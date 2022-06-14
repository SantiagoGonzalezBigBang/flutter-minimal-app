import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_app/blocs/blocs.dart';

class AuthenticationTitle extends StatelessWidget {
  const AuthenticationTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Text(
          state.isLogin ? 'LOG IN' : 'SIGN UP',
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 2.5,
          ),
        );
      },
    );
  }
}
