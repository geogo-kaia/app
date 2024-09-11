import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/models/offer.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponListBody extends StatelessWidget {
  final Offer offer;
  const CouponListBody(this.offer, {super.key});

  @override
  Widget build(BuildContext context) {
    var imageUrl =
        "https://www.hkejetso.com/wp-content/uploads/2020/08/pizza-hut-buy-1-get-1-free-aug-31.png";

    var costs = [15, 25, 50, 30];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: offer.images[0].url,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                offer.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Wrap(
                spacing: 8,
                children: [
                  // Text(
                  //     '${DateFormat('yyyy-MM-dd').format(offer.startDate)} - ${DateFormat('yyyy-MM-dd').format(offer.endDate)}',
                  //     style: contentTextStyle),
                  Text(offer.merchant.name, style: descriptionTextStyle)
                ],
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Chip(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 4, vertical: -4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text('${offer.cost.toString()} \$GOT',
                      style: buttonTextStyle.copyWith(fontSize: 12)),
                  backgroundColor: themeData.primaryColor,
                  shape: StadiumBorder(
                      side: BorderSide(color: themeData.primaryColor))),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
