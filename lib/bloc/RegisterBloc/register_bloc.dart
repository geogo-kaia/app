import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geogo/repositories/user_repo.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterHandlerEvent) {
        emit(RegisterLoading());
        try {
          var response = await UserRepository().signUp(
            email: event.email,
            password: event.password,
            firstName: event.firstName,
            lastName: event.lastName,
          );
          emit(RegisterSuccess());
        } catch (error) {
          emit(RegisterFailure(message: error.toString()));
        }
      }
    });
  }
}
