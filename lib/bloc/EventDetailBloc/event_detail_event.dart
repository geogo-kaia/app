part of 'event_detail_bloc.dart';

abstract class EventDetailEvent extends Equatable {
  const EventDetailEvent();
  @override
  List<Object> get props => [];
}

class EventDetailInitialEvent extends EventDetailEvent {
  final String id;
  const EventDetailInitialEvent({required this.id});

  @override
  List<Object> get props => [id];
}
