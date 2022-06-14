import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:minimal_app/blocs/blocs.dart';

class AuthenticationToggleModeButton extends StatelessWidget {
  const AuthenticationToggleModeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationToggleModeEvent()),
          child: Text(
            state.isLogin ? 'Don\'t have an account? Sign up' : 'Already have an account? Log In',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        );
      },
    );
  }
}
