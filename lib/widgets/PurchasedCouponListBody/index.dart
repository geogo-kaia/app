import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/models/order.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchasedCouponListBody extends StatelessWidget {
  final Order order;
  const PurchasedCouponListBody(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 12),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  imageUrl: order.offer.images[0].url,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[200]),
                  fit: BoxFit.cover),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        order.offer.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                          '${DateFormat('yyyy-dd-MM').format(order.offer.startDate)} - ${DateFormat('yyyy-dd-MM').format(order.offer.endDate)}',
                          style: descriptionTextStyle),
                    ),
                    SizedBox(height: 4),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   child: Text(order.offer.merchant.name,
                    //       style: descriptionTextStyle),
                    // ),
                    SizedBox(height: 12),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
