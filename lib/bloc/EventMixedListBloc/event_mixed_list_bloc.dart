import 'package:bloc/bloc.dart';
import 'package:geogo/bloc/EventListBloc/event_list_bloc.dart';
import 'package:geogo/models/event.dart';
import 'package:geogo/repositories/event_repo.dart';
import 'package:equatable/equatable.dart';

part 'event_mixed_list_event.dart';
part 'event_mixed_list_state.dart';

class EventMixedListBloc
    extends Bloc<EventMixedListEvent, EventMixedListState> {
  EventMixedListBloc() : super(EventMixedListInitial()) {
    on<EventMixedListEvent>((event, emit) async {
      if (event is EventMixedListInitialEvent) {
        emit(EventMixedListInitial());
        try {
          final eventMixedList = await EventRepository().listMixed();
          emit(EventMixedListSuccess(eventMixedList: eventMixedList));
        } catch (error) {
          emit(EventMixedListFailure(message: error.toString()));
        }
      }
    });
  }
}
