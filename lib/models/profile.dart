import 'dart:ffi';
import 'dart:io';

class Profile {
  String lastName;
  String firstName;
  String email;
  String avatarUrl;
  String point;
  String invitationCode;
  Profile(this.lastName, this.firstName, this.email, this.avatarUrl, this.point,
      this.invitationCode);

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      json["lastName"],
      json["firstName"],
      json["email"],
      json["avatarUrl"],
      json['point'],
      json['invitationCode']);
}
