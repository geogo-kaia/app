part of 'coupon_list_bloc.dart';

abstract class CouponListState extends Equatable {
  const CouponListState();

  @override
  List<Object> get props => [];
}

class CouponListInitial extends CouponListState {}

class CouponListLoading extends CouponListState {}

class CouponListEmpty extends CouponListState {}

class CouponListSuccess extends CouponListState {
  final List<Order> orders;
  final int page;
  const CouponListSuccess({required this.orders, required this.page});

  @override
  List<Object> get props => [orders, page];
}

class CouponListFailure extends CouponListState {
  final String message;
  final int page;
  const CouponListFailure({required this.message, required this.page});

  @override
  List<Object> get props => [message, page];

  @override
  String toString() => message;
}
