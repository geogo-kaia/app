import 'dart:ffi';
import 'dart:io';

class Merchant {
  String _id;
  String name;
  String avatarUrl;
  String websiteUrl;
  String description;

  Merchant(
      this._id, this.name, this.avatarUrl, this.websiteUrl, this.description);

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        json['_id'],
        json['name'],
        json['avatarUrl'],
        json['websiteUrl'],
        json['description'],
      );

  Map<String, dynamic> toJson() => {
        "_id": _id,
        "name": name,
        "avatarUrl": avatarUrl,
        "websiteUrl": websiteUrl,
      };
}
