part of 'coupon_list_bloc.dart';

abstract class CouponListEvent extends Equatable {
  const CouponListEvent();

  @override
  List<Object> get props => [];
}

class CouponListInitialEvent extends CouponListEvent {
  final int page;
  const CouponListInitialEvent({required this.page});

  @override
  List<Object> get props => [page];
}
