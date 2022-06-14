import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:minimal_app/screens/screens.dart';
import 'package:minimal_app/services/services.dart';
import 'package:minimal_app/ui/ui.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc() : super(const AuthenticationState()) {

    on<AuthenticationTogglePasswordObscureEvent>(onAuthenticationTogglePasswordObscureEvent);
    on<AuthenticationToggleModeEvent>(onAuthenticationToggleModeEvent);

    on<AuthenticationSendFormEvent>(onAuthenticationSendFormEvent);

  }

  final GlobalKey<FormState> authenticationFormKey = GlobalKey<FormState>();

  final TextEditingController emailTextEditingController    = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  final authenticationService = AuthenticationService();

  //* Events
  void onAuthenticationTogglePasswordObscureEvent(AuthenticationTogglePasswordObscureEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  void onAuthenticationToggleModeEvent(AuthenticationToggleModeEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(isLogin: !state.isLogin));
  }

  void onAuthenticationSendFormEvent(AuthenticationSendFormEvent event, Emitter<AuthenticationState> emit) async {
    FocusScope.of(event.context).unfocus();
    if (!isValidForm()) return;
    emit(state.copyWith(isLoading: true));
  
    if (state.isLogin) {
      await authenticationService.logIn(
        email: emailTextEditingController.text, 
        password: passwordTextEditingController.text
      ).then((value) {
        if (value.success) {
          //TODO: Save token to secure storage
          Navigator.pushReplacement(event.context, MaterialPageRoute(
            builder: (context) => const ClientsScreen(),
          ));
        } else {
          if (value.errorModel != null) {
            ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBars.getNormalSnackBar(value.errorModel!.message)
            );
          }
        }
      });
    } else {
      await authenticationService.signUp(
        email: emailTextEditingController.text, 
        password: passwordTextEditingController.text
      ).then((value) {
        if (value.success) {
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBars.getNormalSnackBar('Account created successfully')
          );
          emit(state.copyWith(isLogin: true));
        } else {
          if (value.errorModel != null) {
            ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBars.getNormalSnackBar(value.errorModel!.message)
            );
          }
        }
      });
    }
        
    emit(state.copyWith(isLoading: false));
  }

  //* Methods
  bool isValidForm() {
    return authenticationFormKey.currentState?.validate() ?? false;
  }

}
