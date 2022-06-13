part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginTooglePasswordObscureEvent extends LoginEvent {}

class LoginSendFormEvent extends LoginEvent {
  const LoginSendFormEvent(this.context);
  final BuildContext context;
}

