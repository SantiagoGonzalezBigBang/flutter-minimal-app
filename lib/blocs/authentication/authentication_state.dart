part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.isLoading = false, 
    this.isPasswordObscure = true,
    this.isLogin = true
  });

  final bool isLoading;
  final bool isPasswordObscure;
  final bool isLogin;

  AuthenticationState copyWith({
    bool? isLoading,
    bool? isPasswordObscure,
    bool? isLogin,
  }) => AuthenticationState(
    isLoading: isLoading ?? this.isLoading,
    isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    isLogin: isLogin ?? this.isLogin
  );
  
  @override
  List<Object> get props => [isLoading, isPasswordObscure, isLogin];
}

