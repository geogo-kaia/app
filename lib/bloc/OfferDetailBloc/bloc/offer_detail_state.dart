part of 'offer_detail_bloc.dart';

abstract class OfferDetailState extends Equatable {
  const OfferDetailState();

  @override
  List<Object> get props => [];
}

class OfferDetailInitial extends OfferDetailState {}

class OfferDetailSuccess extends OfferDetailState {
  final Offer offer;
  final String id;
  const OfferDetailSuccess({required this.offer, required this.id});

  @override
  List<Object> get props => [offer, id];
}

class OfferDetailFailure extends OfferDetailState {
  final String message;
  final String id;
  const OfferDetailFailure({required this.message, required this.id});

  @override
  List<Object> get props => [message, id];

  @override
  String toString() => message;
}
