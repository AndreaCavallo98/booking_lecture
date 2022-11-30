import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Booking {
  late int id;
  late String course_title;
  late String course_color;
  late String teacher_name_surname;
  late int id_user;
  late DateTime date;
  late int start_time;
  late int end_time;
  late bool confirmed;
  late bool deleted;
  late bool has_review;

  Booking(
      {required this.id,
      required this.course_title,
      required this.course_color,
      required this.teacher_name_surname,
      required this.id_user,
      required this.date,
      required this.start_time,
      required this.end_time,
      required this.confirmed,
      required this.deleted,
      required this.has_review});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course_title = json['course_title'];
    course_color = json['course_color'];
    teacher_name_surname = json['teacher_name_surname'];
    id_user = json['id_user'];
    date =
        DateTime.parse(Jiffy(json['date'], "dd/MM/yyyy").format("yyyy-MM-dd"));
    start_time = json['start_time'];
    end_time = json['end_time'];
    confirmed = json['confirmed'];
    deleted = json['deleted'];
    has_review = json['has_review'];
  }
}
