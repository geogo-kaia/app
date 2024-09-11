import 'package:geogo/constants/theme.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            width: 80,
            height: 80,
            child: Image.asset(
              "assets/images/loading.gif",
              // color: themeData.primaryColor,
            )));
  }
}
