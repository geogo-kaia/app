import 'package:geogo/bloc/EventListBloc/event_list_bloc.dart';
import 'package:geogo/bloc/EventMixedListBloc/event_mixed_list_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/EventDetailPage/index.dart';
import 'package:geogo/pages/EventListPage/index.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:geogo/pages/RegisterPage/index.dart';
import 'package:geogo/widgets/ActivityListBody/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/CategoryListBody/index.dart';
import 'package:geogo/widgets/CombinedScrollView/index.dart';
import 'package:geogo/widgets/EventListBody/index.dart';
import 'package:geogo/widgets/Header/TitleHeader/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/SilverAppBarScrollView/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EventHomePage extends StatefulWidget {
  const EventHomePage();
  @override
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  @override
  void initState() {
    super.initState();
  }

  stateHandler(context, state) {
    if (state is EventMixedListFailure) {
      print(state.message);
      print("ERROR ON FETCHING EVENTS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventMixedListBloc()..add(EventMixedListInitialEvent()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: themeData.backgroundColor,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(12),
          child: BlocListener<EventMixedListBloc, EventMixedListState>(
            listener: (context, state) {
              stateHandler(context, state);
            },
            child: BlocBuilder<EventMixedListBloc, EventMixedListState>(
              builder: (context, state) {
                if (state is EventMixedListInitial) {
                  return LoadingIndicator();
                } else if (state is EventMixedListSuccess) {
                  return SilverAppBarScrollView(
                    title: "Events",
                    widgets: <Widget>[
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.7 * 9 / 16 +
                                100,
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: state.eventMixedList[0].length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => EventDetailPage(
                                              eventId: state
                                                  .eventMixedList[0][index]
                                                  .id))),
                                  child: EventListBody(
                                      state.eventMixedList[0][index]));
                            }),
                      ),
                      // TitleHeader(
                      //   text: "Category",
                      //   action: () => Navigator.push(context,
                      //       CupertinoPageRoute(builder: (context) => LoginPage())),
                      // ),
                      // Container(
                      //   height: 100,
                      //   alignment: Alignment.centerLeft,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       shrinkWrap: true,
                      //       physics: ScrollPhysics(),
                      //       itemCount: 6,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return GestureDetector(
                      //             onTap: () => Navigator.push(
                      //                 context,
                      //                 CupertinoPageRoute(
                      //                     builder: (context) => LoginPage())),
                      //             child: CategoryListBody(index: index));
                      //       }),
                      // ),
                      SizedBox(height: 16),
                      TitleHeader(
                          text: "Trending",
                          action: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      EventListPage(title: "Trending")))),
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.7 * 9 / 16 +
                                100,
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: state.eventMixedList[1].length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => EventDetailPage(
                                              eventId: state
                                                  .eventMixedList[1][index]
                                                  .id))),
                                  child: EventListBody(
                                      state.eventMixedList[1][index]));
                            }),
                      ),
                      SizedBox(height: 16),
                      TitleHeader(
                          text: "Newly Added",
                          action: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      EventListPage(title: "Newly Added")))),
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.7 * 9 / 16 +
                                100,
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: state.eventMixedList[2].length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => EventDetailPage(
                                              eventId: state
                                                  .eventMixedList[2][index]
                                                  .id))),
                                  child: EventListBody(
                                      state.eventMixedList[2][index]));
                            }),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text("Empty", style: contentTextStyle));
                }
              },
            ),
          ),
        )),
      ),
    );
  }
}
