import 'package:geogo/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({Key? key, required this.text, required this.action})
      : super(key: key);

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: headerTitleStyle,
            ),
            InkWell(
              child: Text(
                "See All",
                style: miniTextStyle,
              ),
              onTap: this.action,
            )
          ]),
    );
  }
}
