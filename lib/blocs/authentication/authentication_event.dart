part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationTogglePasswordObscureEvent extends AuthenticationEvent {}

class AuthenticationToggleModeEvent extends AuthenticationEvent {}

class AuthenticationSendFormEvent extends AuthenticationEvent {
  const AuthenticationSendFormEvent(this.context);
  final BuildContext context;
}

class AuthenticationAutomaticLoginEvent extends AuthenticationEvent {
  const AuthenticationAutomaticLoginEvent(this.context);
  final BuildContext context;
}