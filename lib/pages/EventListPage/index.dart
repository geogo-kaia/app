import 'package:geogo/bloc/EventListBloc/event_list_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/EventDetailPage/index.dart';
import 'package:geogo/widgets/EventListBody/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListPage extends StatefulWidget {
  final String title;
  const EventListPage({required this.title});
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  void initState() {
    super.initState();
  }

  stateHandler(context, state) {
    if (state is EventListFailure) {
      print("ERROR ON FETCHING Events");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventListBloc()..add(EventListInitialEvent(page: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: themeData.backgroundColor,
        body: BlocListener<EventListBloc, EventListState>(
          listener: (context, state) {
            stateHandler(context, state);
          },
          child: BlocBuilder<EventListBloc, EventListState>(
              builder: (context, state) {
            if (state is EventListInitial) {
              return LoadingIndicator();
            } else if (state is EventListSuccess) {
              {
                return SafeArea(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: state.events.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: GestureDetector(
                                      onTap: () => {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        EventDetailPage(
                                                            eventId: state
                                                                .events[index]
                                                                .id)))
                                          },
                                      child:
                                          EventListBody(state.events[index])),
                                );
                              }),
                        )));
              }
            } else {
              return Center(child: Text("Empty", style: contentTextStyle));
            }
          }),
        ),
      ),
    );
  }
}
