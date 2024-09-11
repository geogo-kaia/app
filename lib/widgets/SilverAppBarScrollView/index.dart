import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/MyCouponPage/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SilverAppBarScrollView extends StatelessWidget {
  const SilverAppBarScrollView(
      {super.key, required this.widgets, required this.title});
  final List<Widget> widgets;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(title),
            backgroundColor: themeData.backgroundColor,
            border: null,
            trailing: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.card_giftcard,
                size: 24,
                color: Colors.black54,
              ),
              onPressed: () => {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => MyCouponPage()))
              },
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(widgets))
        ]);
  }
}
