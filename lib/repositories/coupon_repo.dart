import 'package:geogo/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geogo/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:geogo/utils/exception_helper.dart';

class CouponRepository {
  var options = BaseOptions(
    baseUrl: "http://18.163.48.207:3000/api/v1",
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Order> createOrder(offerId) async {
    Dio dio = Dio(options);
    try {
      final tokenResult = await _firebaseAuth.currentUser;
      final accessToken = await tokenResult?.getIdToken();
      options.headers['Authorization'] = "Bearer ${accessToken}";
      Response response = await dio.post("/orders/create", data: {
        'offer': offerId,
      });
      var obj = json.decode(response.toString())["order"];
      Order order = Order.fromJson(obj);
      return order;
    } on DioError catch (e) {
      throw APIError(e);
    }
  }

  Future<List<Order>> list(page) async {
    final tokenResult = await _firebaseAuth.currentUser;
    final accessToken = await tokenResult?.getIdToken();
    options.headers['Authorization'] = "Bearer ${accessToken}";
    // options.headers['X-Localization'] = await getLocale();
    Dio dio = Dio(options);
    try {
      Response response = await dio.get("/users/coupons");
      Iterable l = json.decode(response.toString())['coupons'];
      List<Order> orders = l.map((obj) => Order.fromJson(obj)).toList();
      return orders;
    } on DioError catch (e) {
      throw APIError(e);
    }
  }
}
