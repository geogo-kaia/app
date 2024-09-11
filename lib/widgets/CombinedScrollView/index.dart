import 'package:flutter/material.dart';

class CombinedScrollView extends StatelessWidget {
  const CombinedScrollView({super.key, required this.widgets});
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate(widgets))
        ]);
  }
}
