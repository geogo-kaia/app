import 'package:geogo/bloc/OfferDetailBloc/bloc/offer_detail_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/widgets/CombinedScrollView/index.dart';
import 'package:geogo/widgets/IconListTile/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:geogo/widgets/RedeemConfirmationBottomSheet/index.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferDetailPage extends StatefulWidget {
  const OfferDetailPage({required this.offerId});
  final String offerId;

  @override
  _OfferDetailPageState createState() => _OfferDetailPageState();
}

class _OfferDetailPageState extends State<OfferDetailPage> {
  var carouselIndex = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var images = [
      "https://www.hkejetso.com/wp-content/uploads/2020/08/pizza-hut-buy-1-get-1-free-aug-31.png",
      "https://static01-proxy.hket.com/res/v3/image/content/2685000/2688922/10646071_1024.jpg",
      "https://www.offeraty.com/sites/offeraty.com/files/offers/adidas-original-bundle-offer-offer-22834.jpeg",
      "https://blog.getjetso.hk/wp-content/uploads/2020/11/cdn-68-800x500.jpg",
    ];

    stateHandler(context, state) {
      if (state is OfferDetailFailure) {
        print("ERROR ON GETTING OFFER");
      }
    }

    return BlocProvider(
        create: (context) =>
            OfferDetailBloc()..add(OfferDetailInitialEvent(id: widget.offerId)),
        child: BlocListener<OfferDetailBloc, OfferDetailState>(
          listener: (context, state) {
            stateHandler(context, state);
          },
          child: BlocBuilder<OfferDetailBloc, OfferDetailState>(
            builder: (context, state) {
              if (state is OfferDetailInitial) {
                return Scaffold(
                    appBar: transparentAppBar(),
                    backgroundColor: themeData.backgroundColor,
                    body: LoadingIndicator());
              } else if (state is OfferDetailSuccess) {
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
                              items: state.offer.images.map((image) {
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
                                dotsCount: state.offer.images.length,
                                position: carouselIndex,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 22, right: 22, bottom: 2),
                          child: Text(
                            state.offer.category.name,
                            style: subHeaderTitleStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 22, right: 22),
                          child: Text(
                            state.offer.title,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 0.5,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 4, left: 22, right: 22),
                            child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: -4),
                                label: Text('${state.offer.cost} \$GOT',
                                    style:
                                        buttonTextStyle.copyWith(fontSize: 12)),
                                backgroundColor: themeData.primaryColor,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: themeData.primaryColor))),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: IconListTile(
                            title:
                                '${DateFormat('yyyy-MM-dd').format(state.offer.startDate)} - ${DateFormat('yyyy-MM-dd').format(state.offer.endDate)}',
                            iconData: Icons.date_range,
                            action: () => {},
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: IconListTile(
                            title: state.offer.merchant.name,
                            iconData: Icons.sell_outlined,
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
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text(state.offer.description,
                              style: contentTextStyle),
                        ),
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
              child: ConfirmationSlider(
                text: "Swipe to buy coupon",
                backgroundColor: themeData.primaryColor,
                textStyle: TextStyle(color: Colors.black87, fontSize: 12),
                sliderButtonContent:
                    Image.asset('assets/images/swipe_logo.png'),
                foregroundColor: Colors.black,
                height: 45,
                width: MediaQuery.of(context).size.width * 0.85,
                onConfirmation: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return RedeemConfirmationBottomSheet(
                            offer: state.offer);
                      });
                },
              ),
            )),
      );
}
