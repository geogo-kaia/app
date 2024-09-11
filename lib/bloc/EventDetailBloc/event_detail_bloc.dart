import 'package:bloc/bloc.dart';
import 'package:geogo/models/event.dart';
import 'package:geogo/repositories/event_repo.dart';
import 'package:equatable/equatable.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailInitial()) {
    on<EventDetailEvent>((blocEvent, emit) async {
      if (blocEvent is EventDetailInitialEvent) {
        emit(EventDetailInitial());
        try {
          final event = await EventRepository().get(blocEvent.id);
          emit(EventDetailSuccess(event: event, id: blocEvent.id));
        } catch (error) {
          emit(EventDetailFailure(message: error.toString(), id: blocEvent.id));
        }
      }
    });
  }
}
