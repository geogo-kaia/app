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

class CheckpointRewardPage extends StatefulWidget {
  const CheckpointRewardPage();
  @override
  _CheckpointRewardPageState createState() => _CheckpointRewardPageState();
}

class _CheckpointRewardPageState extends State<CheckpointRewardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: _buildBottomSheet(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () =>
                  {Navigator.popUntil(context, (route) => route.isFirst)}),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          ),
          title: Text(
            "Congratulation !",
            style: TextStyle(color: Colors.black),
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
              ShareCard(),
              SizedBox(height: 40),
            ],
          )),
        ));
  }

  Widget _buildBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 34),
          child: Container(
              height: 120,
              width: double.infinity,
              child: Column(
                children: [
                  Text("Share to your friends", style: contentTextStyle),
                  SizedBox(height: 12),
                  Wrap(
                    children: [
                      IconTextButton(
                          title: "Download",
                          imageUrl: "assets/images/share_download.png",
                          action: () => {}),
                      IconTextButton(
                          title: "Instagram Stroy",
                          imageUrl: "assets/images/share_instagram.png",
                          action: () => {}),
                      IconTextButton(
                          title: "Facebook Story",
                          imageUrl: "assets/images/share_facebook.png",
                          action: () => {}),
                      IconTextButton(
                          title: "More",
                          imageUrl: "assets/images/share_more.png",
                          action: () => {}),
                    ],
                  )
                ],
              ))),
    );
  }
}
