part of 'event_detail_bloc.dart';

abstract class EventDetailState extends Equatable {
  const EventDetailState();

  @override
  List<Object> get props => [];
}

class EventDetailInitial extends EventDetailState {}

class EventDetailLoading extends EventDetailState {}

class EventDetailSuccess extends EventDetailState {
  final Event event;
  final String id;
  const EventDetailSuccess({required this.event, required this.id});

  @override
  List<Object> get props => [event, id];
}

class EventDetailFailure extends EventDetailState {
  final String message;
  final String id;
  const EventDetailFailure({required this.message, required this.id});

  @override
  List<Object> get props => [message, id];

  @override
  String toString() => message;
}
