import 'dart:convert';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TeacherController extends GetxController {
  var isLoading = false.obs;
  List<Teacher> teacherList = <Teacher>[].obs;
  int maxSliderHourlyRate = 1;

  int filterCourseId = -1;
  String filterDate = "";
  int filterMaxHourlyRate = 0;

  getTeacher(String type) async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'http://192.168.1.3:8080/Prenotazioni0_war_exploded/ServletTeacher?type=$type&courseid=$filterCourseId&avaliabledate=$filterDate&maxhourlyrate=$filterMaxHourlyRate')!);
      //'http://localhost:8080/Prenotazioni0_war_exploded/ServletTeacher?type=$type&courseid=$filterCourseId&avaliabledate=$filterDate&maxhourlyrate=$filterMaxHourlyRate')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
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

  getMaxHourlyRateVaule() async {
    try {
      http.Response response = await http.get(Uri.tryParse(
          'http://192.168.1.3:8080/Prenotazioni0_war_exploded/ServletTeacher?type=maxhourlyrate')!);
      //'http://localhost:8080/Prenotazioni0_war_exploded/ServletTeacher?type=maxhourlyrate')!);
      print(response.body);
      if (response.statusCode == 200) {
        maxSliderHourlyRate = int.parse(response.body);
      } else {
        print("Error while fatching data");
      }
    } catch (e) {
      print("Error exception");
    }
  }
}
