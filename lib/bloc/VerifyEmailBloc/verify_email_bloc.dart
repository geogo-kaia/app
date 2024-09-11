import 'package:bloc/bloc.dart';
import 'package:geogo/repositories/user_repo.dart';
import 'package:equatable/equatable.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<VerifyEmailEvent>((event, emit) async {
      if (event is VerifyEmailInitialEvent) {
        emit(VerifyEmailLoading());
        try {
          await UserRepository().verifyEmail(code: event.code);
          emit(VerifyEmailSuccess());
        } catch (error) {
          emit(VerifyEmailFailure(message: error.toString()));
        }
      } else if (event is VerifyEmailResendEvent) {
        emit(VerifyEmailLoading());
        try {
          await UserRepository().resendVerifyEmail(email: event.email);
          emit(VerifyEmailSuccess());
        } catch (error) {
          emit(VerifyEmailFailure(message: error.toString()));
        }
      }
    });
  }
}
