// ignore_for_file: library_private_types_in_public_api

import 'package:geogo/bloc/TabBarBloc/tabbar_bloc.dart';
import 'package:geogo/bloc/TabBarBloc/tabbar_event.dart';
import 'package:geogo/bloc/TabBarBloc/tabbar_state.dart';
import 'package:geogo/pages/DemoPage/index.dart';
import 'package:geogo/pages/EventPage/index.dart';
import 'package:geogo/pages/HomePage/index.dart';
import 'package:geogo/pages/MapPage/index.dart';
import 'package:geogo/pages/ProfilePage/index.dart';
import 'package:geogo/pages/RewardPage/index.dart';
import 'package:geogo/widgets/TabBar/bottom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});
  @override
  _TabBarAppState createState() => _TabBarAppState();
}

const _pages = [
  MapPage(),
  // DemoPage(),
  EventHomePage(),
  RewardPage(),
  ProfilePage(),
];

class _TabBarAppState extends State<TabBarApp> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBarBloc()..add(const NavigationEvent(0)),
      child: BlocBuilder<TabBarBloc, TabBarState>(builder: (context, state) {
        return Scaffold(
            body: _pages[(state as NavigationState).index],
            bottomNavigationBar: BottomTabBar(
                (state).index,
                ((index) => BlocProvider.of<TabBarBloc>(context)
                    .add(NavigationEvent(index)))));
      }),
    );
  }
}
