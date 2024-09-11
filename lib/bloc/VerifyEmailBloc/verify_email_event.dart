part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailInitialEvent extends VerifyEmailEvent {
  final String code;

  const VerifyEmailInitialEvent({required this.code});

  @override
  List<Object> get props => [code];
}

class VerifyEmailResendEvent extends VerifyEmailEvent {
  final String email;
  const VerifyEmailResendEvent({required this.email});

  @override
  List<Object> get props => [email];
}
