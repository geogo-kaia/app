import 'package:geogo/bloc/EventDetailBloc/event_detail_bloc.dart';
import 'package:geogo/bloc/OfferDetailBloc/bloc/offer_detail_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/EventScanCodePage/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/CombinedScrollView/index.dart';
import 'package:geogo/widgets/IconListTile/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:geogo/widgets/RedeemConfirmationBottomSheet/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({required this.eventId});
  final String eventId;

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  var carouselIndex = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stateHandler(context, state) {
      if (state is EventDetailFailure) {
        print("ERROR ON GETTING OFFER");
      }
    }

    return BlocProvider(
        create: (context) =>
            EventDetailBloc()..add(EventDetailInitialEvent(id: widget.eventId)),
        child: BlocListener<EventDetailBloc, EventDetailState>(
          listener: (context, state) {
            stateHandler(context, state);
          },
          child: BlocBuilder<EventDetailBloc, EventDetailState>(
            builder: (context, state) {
              if (state is EventDetailInitial) {
                return Scaffold(
                    appBar: transparentAppBar(),
                    backgroundColor: themeData.backgroundColor,
                    body: LoadingIndicator());
              } else if (state is EventDetailSuccess) {
                return Scaffold(
                    bottomSheet: buildBottomSheet(state),
                    extendBodyBehindAppBar: true,
                    appBar: transparentAppBar(),
                    backgroundColor: themeData.backgroundColor,
                    body: CombinedScrollView(
                      widgets: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                enableInfiniteScroll: false,
                                height:
                                    (MediaQuery.of(context).size.width * 3 / 4),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    carouselIndex = index.toDouble();
                                  });
                                },
                              ),
                              items: state.event.images.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return CachedNetworkImage(
                                      imageUrl: image.url,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(color: Colors.grey[200]),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: DotsIndicator(
                                decorator: DotsDecorator(
                                  color: Colors.white38,
                                  activeColor: Colors.white,
                                  activeSize: const Size(24, 4),
                                  size: const Size(16, 4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                ),
                                dotsCount: state.event.images.length,
                                position: carouselIndex,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 22, right: 22, bottom: 2),
                          child: Text(
                            state.event.category.name,
                            style: subHeaderTitleStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 22, right: 22),
                          child: Text(
                            state.event.title,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 0.5,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 22, right: 22),
                          child: Text(
                            state.event.subTitle,
                            maxLines: 2,
                            style: contentTextStyle,
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         top: 4, left: 22, right: 22),
                        //     child: Chip(
                        //         labelPadding: EdgeInsets.symmetric(
                        //             horizontal: 4, vertical: -4),
                        //         label: Text('${state.event.cost} \$GOT',
                        //             style:
                        //                 buttonTextStyle.copyWith(fontSize: 12)),
                        //         backgroundColor: themeData.primaryColor,
                        //         shape: StadiumBorder(
                        //             side: BorderSide(
                        //                 color: themeData.primaryColor))),
                        //   ),
                        // ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: IconListTile(
                            title: state.event.merchant.name,
                            iconData: Icons.corporate_fare,
                            action: () => {},
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: IconListTile(
                            title:
                                '${DateFormat('yyyy-MM-dd').format(state.event.startDate)} - ${DateFormat('yyyy-MM-dd').format(state.event.endDate)}',
                            iconData: Icons.date_range,
                            action: () => {},
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: IconListTile(
                            title: state.event.location,
                            iconData: Icons.pin_drop,
                            action: () => {},
                          ),
                        ),
                        SizedBox(height: 12),
                        Divider(thickness: 6, color: Colors.grey[100]),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text("Description", style: contentTitleStyle),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text(state.event.description,
                              style: contentTextStyle),
                        ),
                        SizedBox(height: 24),
                        Divider(thickness: 6, color: Colors.grey[100]),
                        SizedBox(height: 16),
                        Center(
                            child: Column(children: [
                          SizedBox(height: 32),
                          CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.1,
                              backgroundImage:
                                  NetworkImage(state.event.merchant.avatarUrl)),
                          SizedBox(height: 24),
                          Text(state.event.merchant.name,
                              style: contentBoldTextStyle),
                          SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Text(
                              state.event.merchant.description,
                              style: contentTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 16),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () => _navigateToWebView(
                                    context,
                                    state.event.merchant.websiteUrl,
                                    state.event.merchant.name),
                                icon: Icon(Icons.link),
                                color: Colors.black),
                          )
                        ])),
                        SizedBox(height: 32),
                        SizedBox(height: 120),
                      ],
                    ));
              } else {
                return Center(child: Text("Empty", style: contentTextStyle));
              }
            },
          ),
        ));
  }

  _navigateToWebView(context, url, title) async {
    var wkController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {}))
      ..loadRequest(Uri.parse(url));
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: Scaffold(
                    appBar: AppBar(title: Text(title)),
                    body: SafeArea(
                        child: WebViewWidget(controller: wkController)),
                  ),
                )));
  }

  AppBar transparentAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(128, 128, 128, 1), //change your color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => {Navigator.pop(context)},
        ),
      );

  Widget buildBottomSheet(state) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 34),
            child: SizedBox(
                height: 45,
                width: double.infinity,
                child: RoundButton(
                    "Join",
                    themeData.primaryColor,
                    () => {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => EventScanCodePage()))
                        }))),
      );
}
