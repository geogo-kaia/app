import 'package:geogo/bloc/BuyCouponBloc/buy_coupon_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/models/offer.dart';
import 'package:geogo/pages/CouponDetailPage/index.dart';
import 'package:geogo/pages/CouponUsagePage/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemConfirmationBottomSheet extends StatelessWidget {
  final Offer offer;
  const RedeemConfirmationBottomSheet({required this.offer, super.key});

  stateHandler(context, state) {
    if (state is BuyCouponFailure) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
      print("BUY COUPON ERROR");
    } else if (state is BuyCouponSuccess) {
      Navigator.pop(context);
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => CouponDetailPage(order: state.order)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyCouponBloc(),
      child: BlocListener<BuyCouponBloc, BuyCouponState>(
        listener: (context, state) {
          stateHandler(context, state);
        },
        child: BlocBuilder<BuyCouponBloc, BuyCouponState>(
          builder: (context, state) {
            return Wrap(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    "Purchase",
                    textAlign: TextAlign.center,
                    style: contentTitleStyle,
                  ),
                ),
              ),
              Divider(thickness: 1),
              SizedBox(height: 24),
              ListTile(
                subtitle: Text(offer.title, style: contentBoldTextStyle),
                title: Text(offer.category.name, style: termTextStyle),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    imageUrl: offer.images[0].url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 4),
                  child: Wrap(
                    children: [
                      Text(
                        offer.description,
                        style: contentTextStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )),
              SizedBox(height: 64),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: RoundButton(
                  (state is BuyCouponInitial)
                      ? "Confirm for ${offer.cost} \GOT"
                      : "Loading ...",
                  Colors.black,
                  () {
                    // Navigator.pop(context);
                    BlocProvider.of<BuyCouponBloc>(context)
                      ..add(BuyCouponInitialEvent(offerId: offer.id));
                  },
                ),
              ),
              SizedBox(height: 100),
            ]);
          },
        ),
      ),
    );
  }
}
