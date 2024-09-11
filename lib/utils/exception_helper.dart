import 'dart:convert';
import 'package:dio/dio.dart';

class APIException implements Exception {
  final String message;
  const APIException(this.message);
  String toString() => '$message';
}

class APIError implements Exception {
  final DioError error;
  const APIError(this.error);

  String toString() => this.error.response == null
      ? "網絡錯誤 Connection Error"
      : jsonDecode(this.error.response.toString())["message"];
}
