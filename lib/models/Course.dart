import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Course {
  int? id;
  String? title;
  String? color;
  String? image_name;

  Course({
    required this.id,
    required this.title,
    required this.color,
    required this.image_name,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];
    image_name = json['image_name'];
  }
}
