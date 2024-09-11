import 'package:geogo/bloc/OfferDetailBloc/bloc/offer_detail_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'dart:io';
import 'package:flutter/services.dart';
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
import 'package:flutter/material.dart';

class ReferralPage extends StatefulWidget {
  final String referralCode;
  const ReferralPage({required this.referralCode, super.key});

  @override
  _ReferralPageState createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ListView(
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: const [
                    TextSpan(
                        text: "Refer Friends.",
                        style: headerHighlightTitleStyleBlack)
                  ])),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: const [
                    TextSpan(
                        text: "Get 100 GOT Each.",
                        style: headerHighlightTitleStyleBlack)
                  ])),
              Image.asset('assets/images/referral.jpg'),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Theme(
                        data: ThemeData(
                            primarySwatch: Colors.yellow,
                            colorScheme:
                                ColorScheme.light(primary: Color(0xFFFFD43E))),
                        child: Stepper(
                          margin: EdgeInsets.all(0.0),
                          physics: NeverScrollableScrollPhysics(),
                          controlsBuilder: ((context, details) => Container()),
                          currentStep: 2,
                          elevation: 0,
                          steps: const [
                            Step(
                                state: StepState.indexed,
                                title: Text(
                                    'Share your referral link with friends'),
                                content: Text(''),
                                isActive: true),
                            Step(
                                state: StepState.indexed,
                                title: Text('Invite friends to sign up'),
                                content: Text(''),
                                isActive: true),
                            Step(
                                state: StepState.complete,
                                title: Text('Receive 100 GOT rebate each'),
                                content: Text(''),
                                isActive: true),
                          ],
                        ),
                      ))),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            child: Wrap(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Text(
                                      "Referral Code",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromRGBO(27, 26, 31, 0.36),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.05),
                                      textAlign: TextAlign.left,
                                    )),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFf7f7f7),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(widget.referralCode),
                                            Icon(
                                              Icons.copy,
                                              size: 14,
                                              color: Color(0xFFFFD43E),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    await Clipboard.setData(
                                        ClipboardData(text: "qweQWE"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        width: 150,
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24))),
                                        backgroundColor: Colors.white,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 500),
                                        content: Text(
                                          'copied!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                    // copied successfully
                                  },
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Text(
                                      "Referral Link",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromRGBO(27, 26, 31, 0.36),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.05),
                                      textAlign: TextAlign.left,
                                    )),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFf7f7f7),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("http://golabs.xyz/invite"),
                                            Icon(
                                              Icons.copy,
                                              size: 14,
                                              color: Color(0xFFFFD43E),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: "http://golabs.xyz/invite"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        width: 150,
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24))),
                                        backgroundColor: Colors.white,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 500),
                                        content: Text(
                                          'copied!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ); // copied successfully
                                  },
                                ),
                              ],
                            ),
                          )))),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: RoundButton(
                      "Invite friends", themeData.primaryColor, () => {})),
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
