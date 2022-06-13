import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:minimal_app/screens/screens.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(const LoginState()) {

    on<LoginTooglePasswordObscureEvent>(onLoginTooglePasswordObscureEvent);
    on<LoginSendFormEvent>(onLoginSendFormEvent);

  }

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController loginTextEditingController    = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  //* Events
  void onLoginTooglePasswordObscureEvent(LoginTooglePasswordObscureEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  void onLoginSendFormEvent(LoginSendFormEvent event, Emitter<LoginState> emit) async {
    FocusScope.of(event.context).unfocus();
    if (!isValidForm()) return;
    emit(state.copyWith(isLoading: true));
  
    //TODO: Login
    //Success
    //TODO: Save token to secure storage
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(event.context, MaterialPageRoute(
        builder: (context) => const ClientsScreen(),
      ));
    });
    
    emit(state.copyWith(isLoading: false));
  }

  //* Methods
  bool isValidForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }

}
