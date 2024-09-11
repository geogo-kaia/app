import 'dart:ffi';
import 'dart:io';

class Category {
  String id;
  String name;
  String type;

  Category(this.id, this.name, this.type);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        json["id"],
        json["name"],
        json["type"],
      );
}
