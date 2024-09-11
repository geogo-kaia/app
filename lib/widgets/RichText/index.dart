import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RichTextLabel extends StatelessWidget {
  final String content;
  final String linkTitle;
  final String link;
  final VoidCallback action;

  const RichTextLabel(this.content, this.linkTitle, this.link, this.action);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(style: contentTextStyle, text: content, children: [
          TextSpan(
              text: linkTitle,
              style: hintTextStyle,
              recognizer: TapGestureRecognizer()..onTap = () => action)
        ]));
  }
}
