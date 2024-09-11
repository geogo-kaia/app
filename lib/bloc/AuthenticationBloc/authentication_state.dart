part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;
  const AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class AuthenticationSuccess extends AuthenticationState {}
