import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geogo/repositories/user_repo.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoginHandlerEvent) {
        emit(AuthenticationLoading());
        try {
          var response = await UserRepository()
              .signIn(email: event.email, password: event.password);
          emit(AuthenticationSuccess());
        } catch (error) {
          emit(AuthenticationFailure(message: error.toString()));
        }
      } else if (event is LogoutHandlerEvent) {
        emit(AuthenticationLoading());
        try {
          var response = await UserRepository().signOut();
          emit(AuthenticationSuccess());
        } catch (error) {
          emit(AuthenticationFailure(message: error.toString()));
        }
      }
    });
  }
}
