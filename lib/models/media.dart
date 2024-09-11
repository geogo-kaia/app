import 'dart:ffi';
import 'dart:io';

class Media {
  String id;
  String originalname;
  String contentType;
  String url;

  Media(this.id, this.originalname, this.contentType, this.url);

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        json['_id'],
        json['originalname'],
        json['contentType'],
        json['url'],
      );
}
