import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Center(
          widthFactor: 0.5,
          heightFactor: 0.5,
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
    },
  );
}

void hideLoadingDialog(context) {
  Navigator.of(context, rootNavigator: true).pop();
}
