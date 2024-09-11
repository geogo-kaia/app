import 'package:geogo/bloc/OfferListBloc/offer_list_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/OfferDetailPage/index.dart';
import 'package:geogo/widgets/CouponListBody/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:geogo/widgets/SilverAppBarScrollView/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardPage extends StatefulWidget {
  const RewardPage();
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  void initState() {
    super.initState();
  }

  _stateHandler(context, state) {
    if (state is OfferListFailure) {
      print("ERROR ON FETCHING OFFERS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferListBloc()..add(OfferListInitialEvent(page: 1)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: themeData.backgroundColor,
        body: BlocListener<OfferListBloc, OfferListState>(
          listener: (context, state) {
            _stateHandler(context, state);
          },
          child: BlocBuilder<OfferListBloc, OfferListState>(
              builder: (context, state) {
            if (state is OfferListInitial) {
              return LoadingIndicator();
            } else if (state is OfferListSuccess) {
              {
                print(state.offers[0].cost);
                return SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SilverAppBarScrollView(
                    title: "Coupons",
                    widgets: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: state.offers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => OfferDetailPage(
                                              offerId:
                                                  state.offers[index].id))),
                                  child: CouponListBody(state.offers[index]));
                            }),
                      )
                    ],
                  ),
                ));
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
