part of 'event_list_bloc.dart';

abstract class EventListEvent extends Equatable {
  const EventListEvent();

  @override
  List<Object> get props => [];
}

class EventListInitialEvent extends EventListEvent {
  final int page;
  const EventListInitialEvent({required this.page});

  @override
  List<Object> get props => [page];
}
