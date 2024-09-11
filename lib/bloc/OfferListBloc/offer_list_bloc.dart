import 'package:bloc/bloc.dart';
import 'package:geogo/repositories/offer_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:geogo/models/offer.dart';
part 'offer_list_event.dart';
part 'offer_list_state.dart';

class OfferListBloc extends Bloc<OfferListEvent, OfferListState> {
  OfferListBloc() : super(OfferListInitial()) {
    on<OfferListEvent>((event, emit) async {
      if (event is OfferListInitialEvent) {
        emit(OfferListInitial());
        try {
          final offers = await OfferRepository().list(event.page);
          (offers.length == 0)
              ? emit(OfferListEmpty())
              : emit(OfferListSuccess(offers: offers, page: event.page));
        } catch (error) {
          emit(OfferListFailure(page: event.page, message: error.toString()));
        }
      }
    });
  }
}
