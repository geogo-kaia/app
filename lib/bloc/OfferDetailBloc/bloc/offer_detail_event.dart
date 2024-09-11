part of 'offer_detail_bloc.dart';

class OfferDetailEvent extends Equatable {
  const OfferDetailEvent();
  @override
  List<Object> get props => [];
}

class OfferDetailInitialEvent extends OfferDetailEvent {
  final String id;
  const OfferDetailInitialEvent({required this.id});

  @override
  List<Object> get props => [id];
}
