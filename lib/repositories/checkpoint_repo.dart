import 'package:geogo/models/checkpoint.dart';
import 'package:geogo/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:geogo/utils/exception_helper.dart';

class CheckpointRepository {
  var options = BaseOptions(
    baseUrl: "http://18.163.48.207:3000/api/v1",
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  Future<List<Checkpoint>> list(
      {page = 1,
      pageSize = 50,
      maxRadiusinMeter = 4000,
      required LatLng currentPosition}) async {
    Dio dio = Dio(options);
    try {
      Response response = await dio.get("/checkpoints", queryParameters: {
        'page': page,
        'pageSize': pageSize,
        'lng': currentPosition.longitude,
        'lat': currentPosition.latitude,
        'maxDistanceInMeters': maxRadiusinMeter
      });
      Iterable l = json.decode(response.toString())['checkpoints'];
      List<Checkpoint> checkpoints =
          l.map((obj) => Checkpoint.fromJson(obj)).toList();
      return checkpoints;
    } on DioError catch (e) {
      throw APIError(e);
    }
  }
}
