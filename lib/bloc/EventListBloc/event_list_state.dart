part of 'event_list_bloc.dart';

abstract class EventListState extends Equatable {
  const EventListState();

  @override
  List<Object> get props => [];
}

class EventListInitial extends EventListState {}

class EventListSuccess extends EventListState {
  final List<Event> events;
  final int page;

  const EventListSuccess({required this.events, required this.page});
}

class EventListFailure extends EventListState {
  final String message;
  final int page;
  const EventListFailure({required this.message, required this.page});

  @override
  List<Object> get props => [message, page];

  @override
  String toString() => message;
}

class EventListEmpty extends EventListState {}
