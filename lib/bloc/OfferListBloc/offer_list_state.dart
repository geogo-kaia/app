part of 'offer_list_bloc.dart';

abstract class OfferListState extends Equatable {
  const OfferListState();
  @override
  List<Object> get props => [];
}

class OfferListInitial extends OfferListState {}

class OfferListSuccess extends OfferListState {
  final List<Offer> offers;
  final int page;

  const OfferListSuccess({required this.offers, required this.page});

  @override
  List<Object> get props => [offers, page];
}

class OfferListFailure extends OfferListState {
  final String message;
  final int page;
  const OfferListFailure({required this.message, required this.page});

  @override
  List<Object> get props => [message, page];

  @override
  String toString() => message;
}

class OfferListEmpty extends OfferListState {
  const OfferListEmpty();
}
