import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback action;
  const RoundButton(this.title, this.color, this.action);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: themeData.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 8),
              Text(title, style: buttonTextStyle, textScaleFactor: 1),
            ],
          ),
          onPressed: () => action(),
        ));
  }
}
