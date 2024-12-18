import 'dart:convert';

import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/models/Booking.dart';
import 'package:get/get.dart';

import '../utils/GetStorageManager.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  var isLoading = false.obs;
  //List<Booking> myBookingList = <Booking>[].obs;
  List<Booking> myBookingListNoObs = <Booking>[];

  Future<int> addBooking(int courseId, int teacherId, int userId, String date,
      int startTime, int endTime) async {
    int ret = -1;
    String? jwtToken = GetStorageManager.getToken();
    if (jwtToken == null) {
      //authController.logout();
    }

    try {
      isLoading(true);
      // data to string
      http.Response response = await http.post(
        Uri.tryParse(
            //'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletBooking')!,
            'http://localhost:8080/Prenotazioni0_war_exploded/ServletBooking')!,
        headers: {"Authorization": "$jwtToken"},
        body: {
          'courseid': courseId.toString(),
          'teacherid': teacherId.toString(),
          'userid': userId.toString(),
          'date': date,
          'starttime': startTime.toString(),
          'endtime': endTime.toString()
        },
      );

      if (response.statusCode != 401) {
        if (response.statusCode == 200) {
          //var result = jsonDecode(response.body);
          ret = int.parse(response.body);
          print("ID NUOVA PRENOTAZIONE: $ret");
        } else {
          print("Error while fatching data");
        }
      } else {
        //authController.logout();
      }
    } catch (e) {
      print("Error exception $e");
    } finally {
      isLoading(false);
      return ret;
    }
  }

  getMyBookings(String dailyUpcoming) async {
    String? jwtToken = GetStorageManager.getToken();
    int? userId = GetStorageManager.getUserId();
    if (jwtToken == null || userId == null) {
      //authController.logout();
    } else {
      try {
        isLoading(true);
        http.Response response = await http.get(Uri.tryParse(
                //'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletBooking?userid=$userId&dailyupcoming=$dailyUpcoming')!,
                'http://localhost:8080/Prenotazioni0_war_exploded/ServletBooking?userid=$userId&dailyupcoming=$dailyUpcoming')!,
            headers: {"Authorization": "$jwtToken"});

        if (response.statusCode != 401) {
          if (response.statusCode == 200) {
            var result = jsonDecode(response.body);
            myBookingListNoObs =
                List.from(result).map((e) => Booking.fromJson(e)).toList();
          } else {
            print("Error while fatching data");
          }
        } else {
          //authController.logout();
        }
      } catch (e) {
        print("Error exception $e");
      } finally {
        isLoading(false);
      }
    }
  }

  List<Booking> getMyBookingList(bool showDeleted, bool showArchivied) {
    return myBookingListNoObs
        .where(
            (element) => showDeleted ? element.deleted == !showDeleted : true)
        .toList()
        .where((element) =>
            showArchivied ? element.has_review == !showArchivied : true)
        .toList();
  }

  deleteBooking(int bookingId) async {
    String? jwtToken = GetStorageManager.getToken();
    if (jwtToken == null) {
      //authController.logout();
    }

    try {
      //isLoading(true);
      // data to string
      http.Response response = await http.delete(
        Uri.tryParse(
            //'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletBooking?bookingid=${bookingId.toString()}')!,
            'http://localhost:8080/Prenotazioni0_war_exploded/ServletBooking?bookingid=${bookingId.toString()}')!,
        headers: {"Authorization": "$jwtToken"},
      );

      if (response.statusCode != 401) {
        if (response.statusCode == 200) {
          print("booking deleted");
        } else {
          print("Error while fatching data");
        }
      } else {
        //authController.logout();
      }
    } catch (e) {
      print("Error exception $e");
    } finally {
      //isLoading(false);
    }
  }

  markAsDoneBooking(int bookingId) async {
    String? jwtToken = GetStorageManager.getToken();
    if (jwtToken == null) {
      //authController.logout();
    }

    try {
      //isLoading(true);
      // data to string
      http.Response response = await http.put(
        Uri.tryParse(
            //'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletBooking?bookingid=${bookingId.toString()}')!,
            'http://localhost:8080/Prenotazioni0_war_exploded/ServletBooking?bookingid=${bookingId.toString()}')!,
        headers: {"Authorization": "$jwtToken"},
      );

      if (response.statusCode != 401) {
        if (response.statusCode == 200) {
          print("booking confirmed");
        } else {
          print("Error while fatching data");
        }
      } else {
        //authController.logout();
      }
    } catch (e) {
      print("Error exception $e");
    } finally {
      //isLoading(false);
    }
  }
}
