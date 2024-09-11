import 'dart:ffi';
import 'dart:io';

class Coupon {
  String id;
  String code;
  String codeType;
  String offerId;
  String status;

  Coupon(this.id, this.code, this.codeType, this.offerId, this.status);

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        json["_id"],
        json["code"],
        json["codeType"],
        json["offer"],
        json["status"],
      );
}
