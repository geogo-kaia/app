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

class EventScanCodePage extends StatefulWidget {
  const EventScanCodePage();
  @override
  _EventScanCodePageState createState() => _EventScanCodePageState();
}

class _EventScanCodePageState extends State<EventScanCodePage> {
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
              onPressed: () =>
                  {Navigator.popUntil(context, (route) => route.isFirst)}),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: themeData.backgroundColor,
        body: Container(
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
              Image.asset(
                "assets/images/code.png",
                width: MediaQuery.of(context).size.width * 0.85,
              ),
            ],
          )),
        ));
  }
}
