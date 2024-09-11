import 'package:geogo/utils/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geogo/utils/exception_helper.dart';
import 'package:geogo/models/profile.dart';

class UserRepository {
  var options = BaseOptions(
    baseUrl: 'http://18.163.48.207:3000/api/v1',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final tokenResult = await _firebaseAuth.currentUser;

      final idToken = await tokenResult?.getIdToken();
/*       SecureStorage().saveToken(idToken); */

      Dio dio = Dio(options);
      Response response =
          await dio.post("/users/login", data: {"token": idToken});
      var result = json.decode(response.toString());
      print(result["data"]);
      SecureStorage().saveUserData(
        lastName: result["data"]["lastName"],
        firstName: result["data"]["firstName"],
        email: result["data"]["email"],
        avatarUrl: result["data"]["avatarUrl"],
        point: result["data"]["point"],
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw new APIException(jsonDecode(e.code.toString())["message"]);
    } on DioError catch (e) {
      throw new APIException(jsonDecode(e.response.toString())["message"]);
    }
  }

  Future<String> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      String code = ""}) async {
    try {
      Dio dio = Dio(options);
      Response response = await dio.post("/users/signup", data: {
        "type": "EMAIL",
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
      });
      var result = json.decode(response.toString());
      return result["data"];
    } on DioError catch (e) {
      throw new APIException(jsonDecode(e.response.toString())["message"]);
    }
  }

  Future<bool> verifyEmail({
    required String code,
  }) async {
    try {
      Dio dio = Dio(options);
      Response response = await dio.get('/users/verify-email/${code}');
      var result = json.decode(response.toString())['data'];
      return true;
    } on DioError catch (e) {
      throw new APIException(jsonDecode(e.response.toString())["message"]);
    }
  }

  Future<bool> resendVerifyEmail({
    required String email,
  }) async {
    try {
      Dio dio = Dio(options);
      Response response =
          await dio.post("/users/signup", data: {"email": email});
      var result = json.decode(response.toString());
      return result["data"];
    } on DioError catch (e) {
      throw new APIException(jsonDecode(e.response.toString())["message"]);
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final _storage = FlutterSecureStorage();
      _storage.deleteAll();
      return true;
    } on FirebaseAuthException catch (e) {
      throw new APIException(jsonDecode(e.code.toString())["message"]);
    }
  }

  Future<Profile> getProfile() async {
    try {
      Dio dio = Dio(options);
      final tokenResult = await _firebaseAuth.currentUser;
      final accessToken = await tokenResult?.getIdToken();
      options.headers['Authorization'] = "Bearer ${accessToken}";
      Response response = await dio.get('/users/profile');
      var obj = json.decode(response.toString())["profile"];
      SecureStorage().saveInvitationCode(obj['invitationCode']);
      Profile profile = Profile.fromJson(obj);
      return profile;
    } on DioError catch (e) {
      throw new APIException(jsonDecode(e.response.toString())["message"]);
    } catch (e) {
      Map localUserData = await SecureStorage().getLocalUserData();
      Profile profile = Profile(
          localUserData["lastName"],
          localUserData["firstName"],
          localUserData["email"],
          localUserData["avatarUrl"],
          localUserData["point"],
          localUserData["invitationCode"]);
      return profile;
    }
  }
}
