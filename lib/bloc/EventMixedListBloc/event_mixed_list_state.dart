part of 'event_mixed_list_bloc.dart';

abstract class EventMixedListState extends Equatable {
  const EventMixedListState();

  @override
  List<Object> get props => [];
}

class EventMixedListInitial extends EventMixedListState {}

class EventMixedListSuccess extends EventMixedListState {
  final List<List<Event>> eventMixedList;

  const EventMixedListSuccess({required this.eventMixedList});
}

class EventMixedListFailure extends EventMixedListState {
  final String message;
  const EventMixedListFailure({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class EventMixedListEmpty extends EventMixedListState {}
