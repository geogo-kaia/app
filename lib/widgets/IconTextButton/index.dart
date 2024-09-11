import 'package:geogo/constants/text_style.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.action,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        IconButton(
          icon: Image.asset(imageUrl),
          /*       iconSize: 40, */
          onPressed: action,
        ),
        SizedBox(
            /*     width: 80, */
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ))
      ],
    );
  }
}
