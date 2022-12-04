import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:booking_lecture/models/Review.dart';
import 'package:get/get.dart';

import '../utils/GetStorageManager.dart';

class ReviewController extends GetxController {
  var isLoading = false.obs;
  List<Review> reviewList = <Review>[].obs;

  fetchData(int idTeacher) async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'http://192.168.1.8:8080/Prenotazioni0_war_exploded/ServletReview?idteacher=$idTeacher')!);
      //'http://localhost:8080/Prenotazioni0_war_exploded/ServletReview?idteacher=$idTeacher')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        reviewList = List.from(result).map((e) => Review.fromJson(e)).toList();
      } else {
        print("Error while fatching data");
      }
    } catch (e) {
      print("Error exception");
    } finally {
      isLoading(false);
    }
  }

  addReview(int bookingId, int rate, String title, String text) async {
    String? jwtToken = GetStorageManager.getToken();
    if (jwtToken == null) {
      //authController.logout();
    }

    try {
      // data to string
      http.Response response = await http.post(
        Uri.tryParse(
            'http://192.168.1.8:8080/Prenotazioni0_war_exploded/ServletReview')!,
        //'http://localhost:8080/Prenotazioni0_war_exploded/ServletReview')!,
        headers: {"Authorization": "$jwtToken"},
        body: {
          'bookingid': bookingId.toString(),
          'rate': rate.toString(),
          'title': title,
          'text': text
        },
      );

      if (response.statusCode != 401) {
        if (response.statusCode == 200) {
          print("recensione aggiunta");
          //var result = jsonDecode(response.body);

          // pop
          // Nav bar controller su elenco prenorazioni

        } else {
          print("Error while fatching data");
        }
      } else {
        //authController.logout();
      }
    } catch (e) {
      print("Error exception $e");
    }
  }
}
