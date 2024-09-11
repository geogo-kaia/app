import 'package:geogo/bloc/OfferDetailBloc/bloc/offer_detail_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'dart:io';
import 'package:geogo/models/media.dart';
import 'package:geogo/models/order.dart';
import 'package:geogo/pages/OfferDetailPage/index.dart';
import 'package:geogo/widgets/CombinedScrollView/index.dart';
import 'package:geogo/widgets/IconListTile/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:geogo/widgets/RedeemConfirmationBottomSheet/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CouponDetailPage extends StatefulWidget {
  final Order order;
  const CouponDetailPage({required this.order, super.key});

  @override
  _CouponDetailPageState createState() => _CouponDetailPageState();
}

class _CouponDetailPageState extends State<CouponDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppBar(),
        backgroundColor: themeData.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: CombinedScrollView(
            widgets: [
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => OfferDetailPage(
                                offerId: widget.order.offer.id,
                              )))
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                imageUrl: widget.order.offer.images[0].url,
                                placeholder: (context, url) =>
                                    Container(color: Colors.grey[200]),
                                fit: BoxFit.cover),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      widget.order.offer.title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                        widget.order.offer.merchant.name,
                                        style: descriptionTextStyle),
                                  ),
                                  SizedBox(height: 12),
                                ]),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black45,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 16),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                                '${DateFormat('yyyy-dd-MM').format(widget.order.offer.startDate)} - ${DateFormat('yyyy-dd-MM').format(widget.order.offer.endDate)} Valid',
                                style: descriptionTextStyle),
                          ),
                          BarcodeWidget(
                            barcode:
                                Barcode.code128(), // Barcode type and settings
                            data: widget.order.coupon.code, // Content
                            width: 200,
                            height: 80,
                          ),
                          SizedBox(height: 16),
                          // QrImage(
                          //   data: widget.order.coupon.code,
                          //   version: QrVersions.auto,
                          //   size: 200.0,
                          // ),
                          // SizedBox(height: 16),
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 4, vertical: 24),
                          //   width: MediaQuery.of(context).size.width * 0.8,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(16),
                          //     color: Colors.grey[100],
                          //   ),
                          //   child: Text(
                          //     widget.order.coupon.code,
                          //     style: headerHighlightTitleStyleBlack,
                          //     textAlign: TextAlign.center,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Text("Description",
                              style: contentTitleStyle,
                              textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Text(widget.order.offer.description,
                              style: contentTextStyle),
                        )
                      ])),
              SizedBox(height: 12),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(children: [
                    SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Number', style: textFieldTitleStyle),
                          Expanded(
                              child: Text(widget.order.id,
                                  style: iconTileTextStyle,
                                  textAlign: TextAlign.right))
                        ]),
                    SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Timestamp', style: textFieldTitleStyle),
                          Expanded(
                              child: Text(
                                  DateFormat('yyyy-dd-MM HH:mm')
                                      .format(widget.order.createdAt),
                                  style: iconTileTextStyle,
                                  textAlign: TextAlign.right))
                        ]),
                    SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Redeemed Amount', style: textFieldTitleStyle),
                          Expanded(
                              child: Text(
                                  '${widget.order.offer.cost.toString()} \$GOT',
                                  style: iconTileTextStyle,
                                  textAlign: TextAlign.right))
                        ]),
                    SizedBox(height: 12),
                  ])),
              SizedBox(height: 48),
            ],
          ),
        ));
  }

  AppBar transparentAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(128, 128, 128, 1), //change your color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => {Navigator.pop(context)},
        ),
      );
}
