import 'package:bloc/bloc.dart';
import 'package:geogo/models/event.dart';
import 'package:geogo/repositories/event_repo.dart';
import 'package:equatable/equatable.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  EventListBloc() : super(EventListInitial()) {
    on<EventListEvent>((event, emit) async {
      if (event is EventListInitialEvent) {
        emit(EventListInitial());
        try {
          final events = await EventRepository().list(event.page);
          (events.length == 0)
              ? emit(EventListEmpty())
              : emit(EventListSuccess(events: events, page: event.page));
        } catch (error) {
          emit(EventListFailure(message: error.toString(), page: event.page));
        }
      }
    });
  }
}
