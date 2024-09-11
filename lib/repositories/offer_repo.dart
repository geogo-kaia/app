import 'package:geogo/models/offer.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:geogo/utils/exception_helper.dart';

class OfferRepository {
  var options = BaseOptions(
    baseUrl: "http://18.163.48.207:3000/api/v1",
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  Future<List<Offer>> list(page) async {
    // String userToken = await FlutterSecureStorage().read(key: "userToken");
    // options.headers['Authorization'] = "Bearer ${userToken}";
    // options.headers['X-Localization'] = await getLocale();
    Dio dio = Dio(options);
    try {
      Response response = await dio.get("/offers");
      print(response.toString());
      Iterable l = json.decode(response.toString())['offers'];
      List<Offer> offers = l.map((obj) => Offer.fromJson(obj)).toList();
      return offers;
    } on DioError catch (e) {
      throw APIError(e);
    }
  }

  Future<Offer> get(id) async {
    Dio dio = Dio(options);
    try {
      Response response = await dio.get("/offers/${id}");
      var obj = json.decode(response.toString())["offer"];
      Offer offer = Offer.fromJson(obj);
      return offer;
    } on DioError catch (e) {
      throw APIError(e);
    }
  }
}
