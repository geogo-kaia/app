part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginHandlerEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginHandlerEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogoutHandlerEvent extends AuthenticationEvent {
  const LogoutHandlerEvent();

  @override
  List<Object> get props => [];
}
