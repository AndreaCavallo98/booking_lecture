import 'dart:convert';

import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/models/BookingSlot.dart';
import 'package:booking_lecture/utils/GetStorageManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  AuthController authController = Get.find();
  var formatter = new DateFormat('dd/MM/yyyy');

  var selectedDateTime = DateTime.now().obs;
  List<BookingSlot> dailyBookingSoltList = <BookingSlot>[].obs;
  var isLoading = false.obs;

  changeSelectedDate(int teacherId, DateTime selectedDate) async {
    selectedDateTime.value =
        new DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    ;

    String? jwtToken = GetStorageManager.getToken();

    if (jwtToken == null || authController.authId == null) {
      authController.logout();
    }

    try {
      isLoading(true);
      // data to string
      http.Response response = await http.get(Uri.tryParse(
              //'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletCalendar?teacherid=$teacherId&dateday=${formatter.format(selectedDate)}')!,
              'http://localhost:8080/Prenotazioni0_war_exploded/ServletCalendar?type=daily&teacherid=$teacherId&dateday=${formatter.format(selectedDate)}&userid=${authController.authId}')!,
          headers: {"Authorization": "$jwtToken"});

      if (response.statusCode != 401) {
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          dailyBookingSoltList =
              List.from(result).map((e) => BookingSlot.fromJson(e)).toList();
        } else {
          print("Error while fatching data");
        }
      } else {
        authController.logout();
      }
    } catch (e) {
      print("Error exception");
    } finally {
      isLoading(false);
    }
  }
}
