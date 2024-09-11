import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/RegisterPage/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/IconTextButton/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/ShareCard/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_share/social_share.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CouponUsagePage extends StatefulWidget {
  const CouponUsagePage();
  @override
  _CouponUsagePageState createState() => _CouponUsagePageState();
}

class _CouponUsagePageState extends State<CouponUsagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => {Navigator.pop(context)}),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          ),
          title: Text(
            "Successful purchase",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: themeData.backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 48),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(255, 212, 62, 1),
                Color.fromRGBO(238, 142, 30, 1)
              ])),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TicketWidget(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8 * 4 / 3,
                isCornerRounded: true,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchased on 1 Dec 2022",
                      style: TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Get 50% Off Your Custom Engraved Bracelet by Minnen",
                      style: headerTitleStyle,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "By Minnen",
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Image.asset(
                        "assets/images/qr.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          )),
        ));
  }
}
