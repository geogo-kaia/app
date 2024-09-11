import 'dart:ffi';
import 'dart:typed_data';
import 'package:location/location.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Checkpoint {
  String? name;
  String? vicinity;
  String? coverPhotoUrl;
  LatLng location;
  int rewardPoint;
  String googlePlaceId;
  Checkpoint(this.name, this.vicinity, this.coverPhotoUrl, this.location,
      this.rewardPoint, this.googlePlaceId);

  factory Checkpoint.fromJson(Map<String, dynamic> json) => Checkpoint(
        json['name'],
        json['vicinity'],
        json['coverPhotoUrl'],
        LatLng(json['lat'], json['lng']),
        json['rewardPoint'],
        json['googlePlaceId'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "vicinity": vicinity,
        "coverPhotoUrl": coverPhotoUrl,
        "location": location,
        "rewardPoint": rewardPoint,
        "googlePlaceId": googlePlaceId,
      };
}
