import 'package:geogo/models/event.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:geogo/utils/exception_helper.dart';

class EventRepository {
  var options = BaseOptions(
    baseUrl: "http://18.163.48.207:3000/api/v1",
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  Future<List<List<Event>>> listMixed() async {
    // String userToken = await FlutterSecureStorage().read(key: "userToken");
    // options.headers['Authorization'] = "Bearer ${userToken}";
    // options.headers['X-Localization'] = await getLocale();
    Dio dio = Dio(options);
    try {
      Response response = await dio.get('/events/mixed');
      Iterable _events = json.decode(response.toString())['events'];
      Iterable _trendingEvents =
          json.decode(response.toString())['trendingEvents'];
      Iterable _newlyAddedEvents =
          json.decode(response.toString())['newlyAddedEvents'];
      List<Event> events = _events.map((obj) => Event.fromJson(obj)).toList();
      List<Event> trendingEvents =
          _trendingEvents.map((obj) => Event.fromJson(obj)).toList();
      List<Event> newlyAddedEvents =
          _newlyAddedEvents.map((obj) => Event.fromJson(obj)).toList();
      return [events, trendingEvents, newlyAddedEvents];
    } on DioError catch (e) {
      print(e);
      throw APIError(e);
    }
  }

  Future<List<Event>> list(page) async {
    // String userToken = await FlutterSecureStorage().read(key: "userToken");
    // options.headers['Authorization'] = "Bearer ${userToken}";
    // options.headers['X-Localization'] = await getLocale();
    Dio dio = Dio(options);
    try {
      Response response = await dio.get('/events');
      Iterable l = json.decode(response.toString())['events'];
      List<Event> events = l.map((obj) => Event.fromJson(obj)).toList();
      return events;
    } on DioError catch (e) {
      print(e);
      throw APIError(e);
    }
  }

  Future<Event> get(id) async {
    Dio dio = Dio(options);
    try {
      Response response = await dio.get("/events/${id}");
      var obj = json.decode(response.toString())["event"];
      print(obj);
      Event event = Event.fromJson(obj);
      return event;
    } on DioError catch (e) {
      throw APIError(e);
    }
  }
}
