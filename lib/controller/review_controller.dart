import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:booking_lecture/models/Review.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  var isLoading = false.obs;
  List<Review> reviewList = <Review>[].obs;

  fetchData(int idTeacher) async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'http://192.168.1.3:8080/Prenotazioni0_war_exploded/ServletReview?idteacher=$idTeacher')!);
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
}
