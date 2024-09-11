part of 'offer_list_bloc.dart';

class OfferListEvent extends Equatable {
  const OfferListEvent();
  @override
  List<Object> get props => [];
}

class OfferListInitialEvent extends OfferListEvent {
  final int page;
  const OfferListInitialEvent({required this.page});

  @override
  List<Object> get props => [page];
}
