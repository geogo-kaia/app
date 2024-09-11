part of 'buy_coupon_bloc.dart';

abstract class BuyCouponEvent extends Equatable {
  const BuyCouponEvent();

  @override
  List<Object> get props => [];
}

class BuyCouponInitialEvent extends BuyCouponEvent {
  final String offerId;
  const BuyCouponInitialEvent({required this.offerId});

  @override
  List<Object> get props => [offerId];
}
