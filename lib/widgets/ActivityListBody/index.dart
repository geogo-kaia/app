import 'package:geogo/constants/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ActivityListBody extends StatelessWidget {
  final int index;
  const ActivityListBody(this.index);

  @override
  Widget build(BuildContext context) {
    var images = [
      "https://image.kkday.com/v2/image/get/w_1920%2Ch_1080%2Cc_fit%2Cq_55%2Ct_webp/s1.kkday.com/product_38930/20200331091138_FGbVe/jpg",
      "https://image.kkday.com/v2/image/get/w_1920%2Ch_1080%2Cc_fit%2Cq_55%2Ct_webp/s1.kkday.com/product_38421/20200310081017_fluNl/jpg",
      "https://image.kkday.com/v2/image/get/w_1920%2Ch_1080%2Cc_fit%2Cq_55%2Ct_webp/s1.kkday.com/product_39828/20200529091811_qZZ9W/jpg",
      "https://image.kkday.com/v2/image/get/w_1920%2Ch_1080%2Cc_fit%2Cq_55%2Ct_webp/s1.kkday.com/product_38930/20200331091138_FGbVe/jpg",
    ];
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "永生花、乾花相框或擴香石工作坊",
            maxLines: 2,
            style: TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Wrap(
            children: <Widget>[
              Icon(Icons.star, size: 13, color: themeData.primaryColor),
              SizedBox(width: 4),
              Text("4.4",
                  maxLines: 1,
                  style: TextStyle(
                      color: themeData.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 6),
              Text("(250 reviews)",
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 14,
                      fontWeight: FontWeight.w600))
            ],
          ),
          SizedBox(height: 4),
          Text("HKD 380",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
