part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterHandlerEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String code;
  const RegisterHandlerEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.code});

  @override
  List<Object> get props => [firstName, lastName, email, password, code];
}
