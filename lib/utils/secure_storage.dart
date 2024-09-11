import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  void saveUserData({lastName, firstName, email, avatarUrl, point}) {
    final _storage = FlutterSecureStorage();
    _storage.write(key: "lastName", value: lastName);
    _storage.write(key: "firstName", value: firstName);
    _storage.write(key: "email", value: email);
    _storage.write(key: "avatarUrl", value: avatarUrl);
    _storage.write(key: "point", value: point.toString());
    print("$lastName, $firstName, $email, $avatarUrl");
  }

  void saveInvitationCode(invitationCode) {
    final _storage = FlutterSecureStorage();
    _storage.write(key: "invitationCode", value: invitationCode);
  }

  Future<String> getInvitationCode() async {
    final code = await FlutterSecureStorage().read(key: "invitationCode") ?? "";
    return code;
  }

  Future<Map> getLocalUserData() async {
    final lastName = await FlutterSecureStorage().read(key: "lastName") ?? "";
    final firstName = await FlutterSecureStorage().read(key: "firstName") ?? "";
    final email = await FlutterSecureStorage().read(key: "email") ?? "";
    final avatarUrl = await FlutterSecureStorage().read(key: "avatarUrl") ?? "";
    final point = await FlutterSecureStorage().read(key: "point") ?? "";
    final invitationCode =
        await FlutterSecureStorage().read(key: "invitationCode") ?? "";
    return {
      "lastName": lastName,
      "firstName": firstName,
      "email": email,
      "avatarUrl": avatarUrl,
      "point": point,
      "invitationCode": invitationCode
    };
  }
}
