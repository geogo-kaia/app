part of 'event_mixed_list_bloc.dart';

abstract class EventMixedListEvent extends Equatable {
  const EventMixedListEvent();

  @override
  List<Object> get props => [];
}

class EventMixedListInitialEvent extends EventMixedListEvent {
  const EventMixedListInitialEvent();

  @override
  List<Object> get props => [];
}
