import 'package:booking_lecture/models/Course.dart';
import 'package:flutter/material.dart';

class Teacher {
  int? id;
  String? name;
  String? surname;
  String? description;
  List<Course>? teached_courses;
  double? hourly_rate;
  int? num_lectures_given;
  int? num_reviews;
  double? reviews_average;
  String? image_name;

  Teacher(
      {required this.id,
      required this.name,
      required this.surname,
      required this.description,
      required this.teached_courses,
      required this.hourly_rate,
      required this.num_lectures_given,
      required this.num_reviews,
      required this.reviews_average,
      required this.image_name});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    description = json['description'];
    teached_courses = List.from(json['teached_courses'])
        .map((e) => Course.fromJson(e))
        .toList();
    hourly_rate = json['hourly_rate'];
    num_lectures_given = json['num_lectures_given'];
    num_reviews = json['num_reviews'];
    reviews_average = json['reviews_average'];
    image_name = json['image_name'];
  }
}
