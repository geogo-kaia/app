import 'dart:ffi';
import 'dart:io';

import 'package:geogo/models/coupon.dart';
import 'package:geogo/models/offer.dart';

class Order {
  Offer offer;
  Coupon coupon;
  DateTime createdAt;
  String id;

  Order(this.offer, this.coupon, this.createdAt, this.id);

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        Offer.fromJson(json["offer"]),
        Coupon.fromJson(json["coupon"]),
        DateTime.parse(json["createdAt"]),
        json['_id'],
      );
}
