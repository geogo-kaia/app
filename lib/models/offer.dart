import 'dart:ffi';
import 'dart:io';

import 'package:geogo/models/category.dart';
import 'package:geogo/models/media.dart';
import 'package:geogo/models/merchant.dart';

class Offer {
  String id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  num cost;
  num stock;
  Merchant merchant;
  List<Media> images;
  Category category;

  Offer(this.id, this.title, this.description, this.startDate, this.endDate,
      this.cost, this.stock, this.merchant, this.images, this.category);

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        json["_id"] ?? "",
        json["title"] ?? "",
        json['description'] ?? "",
        DateTime.parse(json["startDate"]),
        DateTime.parse(json["endDate"]),
        json["cost"] ?? 0,
        json["stock"] ?? 0,
        Merchant.fromJson(json["merchant"]),
        json['images'].map<Media>((m) {
          return Media.fromJson(m);
        }).toList(),
        Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "cost": cost,
        "stock": stock,
        "merchant": merchant,
        "images": images,
        "category": category
      };
}
