part of 'buy_coupon_bloc.dart';

abstract class BuyCouponState extends Equatable {
  const BuyCouponState();

  @override
  List<Object> get props => [];
}

class BuyCouponInitial extends BuyCouponState {}

class BuyCouponLoading extends BuyCouponState {}

class BuyCouponSuccess extends BuyCouponState {
  final Order order;
  const BuyCouponSuccess({required this.order});

  @override
  List<Object> get props => [order];
}

class BuyCouponFailure extends BuyCouponState {
  final String message;
  const BuyCouponFailure({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}
