part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isLoading = false, 
    this.isPasswordObscure = true
  });

  final bool isLoading;
  final bool isPasswordObscure;

  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordObscure,
  }) => LoginState(
    isLoading: isLoading ?? this.isLoading,
    isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure
  );
  
  @override
  List<Object> get props => [isLoading, isPasswordObscure];
}

