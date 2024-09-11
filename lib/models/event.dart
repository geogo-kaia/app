import 'dart:ffi';
import 'dart:io';

import 'package:geogo/models/category.dart';
import 'package:geogo/models/media.dart';
import 'package:geogo/models/merchant.dart';

class Event {
  String id;
  String title;
  String subTitle;
  String description;
  String location;
  DateTime startDate;
  DateTime endDate;
  Category category;
  Merchant merchant;
  List<Media> images;
  String status;
  String type;

  Event(
      this.id,
      this.title,
      this.subTitle,
      this.description,
      this.location,
      this.startDate,
      this.endDate,
      this.category,
      this.merchant,
      this.images,
      this.status,
      this.type);

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        json["_id"],
        json["title"],
        json["subTitle"],
        json['description'],
        json["location"],
        DateTime.parse(json["startDate"]),
        DateTime.parse(json["endDate"]),
        Category.fromJson(json["category"]),
        Merchant.fromJson(json["merchant"]),
        json['images'].map<Media>((m) {
          return Media.fromJson(m);
        }).toList(),
        json['status'],
        json['eventType'],
      );
}
