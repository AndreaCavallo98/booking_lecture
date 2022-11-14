import 'dart:convert';

import 'package:booking_lecture/models/Course.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseController extends GetxController {
  var isLoading = false.obs;
  List<Course> courseList = <Course>[].obs;

  fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletCourse')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        courseList = List.from(result).map((e) => Course.fromJson(e)).toList();
      } else {
        print("Error while fatching data");
      }
    } catch (e) {
      print("Error exception");
    } finally {
      isLoading(false);
    }
  }
}
