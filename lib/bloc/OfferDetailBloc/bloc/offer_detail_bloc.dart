import 'package:bloc/bloc.dart';
import 'package:geogo/models/offer.dart';
import 'package:geogo/repositories/offer_repo.dart';
import 'package:equatable/equatable.dart';

part 'offer_detail_event.dart';
part 'offer_detail_state.dart';

class OfferDetailBloc extends Bloc<OfferDetailEvent, OfferDetailState> {
  OfferDetailBloc() : super(OfferDetailInitial()) {
    on<OfferDetailEvent>((event, emit) async {
      if (event is OfferDetailInitialEvent) {
        emit(OfferDetailInitial());
        try {
          final offer = await OfferRepository().get(event.id);
          emit(OfferDetailSuccess(offer: offer, id: event.id));
        } catch (error) {
          emit(OfferDetailFailure(message: error.toString(), id: event.id));
        }
      }
    });
  }
}
