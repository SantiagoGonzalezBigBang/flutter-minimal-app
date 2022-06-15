import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:minimal_app/helpers/helpers.dart';
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

    on<AuthenticationLogOutEvent>(onAuthenticationLogOutEvent);
  }

  final authenticationFormKey = GlobalKey<FormState>();

  final emailTextEditingController    = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final authenticationService = AuthenticationService();
  final secureStorageHelper   = SecureStorageHelper();

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
          if (value.response != null) {
            secureStorageHelper.writeToken(value.response!.accessToken);
            secureStorageHelper.writeEmail(value.response!.email);
            secureStorageHelper.writePassword(passwordTextEditingController.text);
            Navigator.pushReplacement(event.context, MaterialPageRoute(
              builder: (context) => const ClientsStateScreen(),
            ));
          }
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

  void onAuthenticationLogOutEvent(AuthenticationLogOutEvent event, Emitter<AuthenticationState> emit) async {

    emailTextEditingController.text = '';
    passwordTextEditingController.text = '';

    Navigator.pushReplacement(event.context, MaterialPageRoute(
      builder: (context) => const AuthenticationScreen(),
    ));

    emit(const AuthenticationState());

    await secureStorageHelper.deleteToken();
    await secureStorageHelper.deleteEmail();
    await secureStorageHelper.deletePassword();
  }

  //* Methods
  bool isValidForm() {
    return authenticationFormKey.currentState?.validate() ?? false;
  }

  Future<bool> isLoggedIn() async {

    final token = await SecureStorageHelper().readToken();
    final email = await SecureStorageHelper().readEmail();
    final password = await SecureStorageHelper().readPassword();

    if (token == null || email == null || password == null) return false;

    final loginResponseModel = await authenticationService.logIn(
      email: email,
      password: password
    );

    if (loginResponseModel.success) {
      if (loginResponseModel.response != null) {
        await secureStorageHelper.writeToken(loginResponseModel.response!.accessToken);
        await secureStorageHelper.writeEmail(email);
        await secureStorageHelper.writePassword(password);
        return true;
      }
    }

    return false;
  }

  @override
  Future<void> close() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    return super.close();
  }

}
