import 'dart:convert';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TeacherController extends GetxController {
  var isLoading = false.obs;
  List<Teacher> teacherList = <Teacher>[].obs;

  getTeacher(String type) async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'http://192.168.1.85:8080/Prenotazioni0_war_exploded/ServletTeacher?type=$type')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        teacherList =
            List.from(result).map((e) => Teacher.fromJson(e)).toList();
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
