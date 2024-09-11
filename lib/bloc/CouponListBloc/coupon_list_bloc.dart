import 'package:bloc/bloc.dart';
import 'package:geogo/models/order.dart';
import 'package:geogo/repositories/coupon_repo.dart';
import 'package:equatable/equatable.dart';

part 'coupon_list_event.dart';
part 'coupon_list_state.dart';

class CouponListBloc extends Bloc<CouponListEvent, CouponListState> {
  CouponListBloc() : super(CouponListInitial()) {
    on<CouponListEvent>((event, emit) async {
      if (event is CouponListInitialEvent) {
        emit(CouponListLoading());
        try {
          final orders = await CouponRepository().list(event.page);
          (orders.length == 0)
              ? emit(CouponListEmpty())
              : emit(CouponListSuccess(orders: orders, page: event.page));
        } catch (error) {
          emit(CouponListFailure(message: error.toString(), page: event.page));
        }
      }
    });
  }
}
