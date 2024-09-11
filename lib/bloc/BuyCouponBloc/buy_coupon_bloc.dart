import 'package:bloc/bloc.dart';
import 'package:geogo/models/order.dart';
import 'package:geogo/repositories/coupon_repo.dart';
import 'package:equatable/equatable.dart';

part 'buy_coupon_event.dart';
part 'buy_coupon_state.dart';

class BuyCouponBloc extends Bloc<BuyCouponEvent, BuyCouponState> {
  BuyCouponBloc() : super(BuyCouponInitial()) {
    on<BuyCouponEvent>((event, emit) async {
      if (event is BuyCouponInitialEvent) {
        emit(BuyCouponLoading());
        try {
          final order = await CouponRepository().createOrder(event.offerId);
          emit(BuyCouponSuccess(order: order));
        } catch (error) {
          emit(BuyCouponFailure(message: error.toString()));
        }
      }
    });
  }
}
