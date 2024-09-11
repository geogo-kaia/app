import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:flutter/material.dart';

class ActionTableListBody extends StatelessWidget {
  const ActionTableListBody({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: action,
      child: Container(
        margin: EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 32),
                  child: Text(title, style: contentTextStyle)),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16, right: 8),
                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
