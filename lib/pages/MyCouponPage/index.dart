import 'package:geogo/bloc/CouponListBloc/coupon_list_bloc.dart';
import 'package:geogo/bloc/OfferListBloc/offer_list_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/CouponDetailPage/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:geogo/widgets/PurchasedCouponListBody/index.dart';
import 'package:geogo/widgets/SilverAppBarScrollView/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCouponPage extends StatefulWidget {
  const MyCouponPage();
  @override
  _MyCouponPageState createState() => _MyCouponPageState();
}

class _MyCouponPageState extends State<MyCouponPage> {
  @override
  void initState() {
    super.initState();
  }

  stateHandler(context, state) {
    if (state is CouponListFailure) {
      print(state.message);
      print("ERROR ON FETCHING COUPONS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CouponListBloc()..add(CouponListInitialEvent(page: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Coupons'),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: themeData.backgroundColor,
        body: BlocListener<CouponListBloc, CouponListState>(
          listener: (context, state) {
            stateHandler(context, state);
          },
          child: BlocBuilder<CouponListBloc, CouponListState>(
              builder: (context, state) {
            if (state is CouponListLoading) {
              return LoadingIndicator();
            } else if (state is CouponListSuccess) {
              {
                return SafeArea(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: state.orders.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      CouponDetailPage(
                                                          order: state
                                                              .orders[index])))
                                        },
                                    child: PurchasedCouponListBody(
                                        state.orders[index]));
                              }),
                        )));
              }
            } else {
              return Center(child: Text("Empty", style: contentTextStyle));
            }
          }),
        ),
      ),
    );
  }
}
