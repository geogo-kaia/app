import 'package:geogo/constants/theme.dart';
import 'package:geogo/models/event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventListBody extends StatelessWidget {
  final Event event;
  const EventListBody(this.event);

  @override
  Widget build(BuildContext context) {
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
                imageUrl: event.images[0].url,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            DateFormat('EEEE, d MMM, yyyy').format(event.startDate.toLocal()),
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            event.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(event.merchant.name,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
