import 'package:geogo/constants/text_style.dart';
import 'package:flutter/material.dart';

class IconListTile extends StatelessWidget {
  const IconListTile({
    Key? key,
    required this.title,
    required this.iconData,
    required this.action,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(children: <Widget>[
          Icon(iconData, size: 18, color: Colors.black87),
          SizedBox(width: 12),
          Expanded(child: Text(title, style: iconTileTextStyle)),
        ]),
      ),
    );
  }
}
