import 'dart:convert';

import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/models/AuthResponse.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

//gio.pasche ti amo <3
class AuthController extends GetxController {
  var isLoading = false.obs;
  final _box = GetStorage();

  var authId = -1;
  var authUsername = "";
  var authSessionToken = "".obs;
  var authImageName = "";

  AuthResponse? authResponse = null;

  checkIfIsConnected() {
    print(_box.read("authSessionToken"));
    if (_box.read("authSessionToken") != null) {
      authId = _box.read("authId");
      authUsername = _box.read("authUsername");
      authSessionToken.value = _box.read("authSessionToken");
      authImageName = _box.read("authImageName");
    }
  }

  login(String username, String password) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse(
            //'http://192.168.1.3:8080/Prenotazioni0_war_exploded/ServletTeacher?type=$type&courseid=$filterCourseId&avaliabledate=$filterDate&maxhourlyrate=$filterMaxHourlyRate')!);
            'http://localhost:8080/Prenotazioni0_war_exploded/servlet-auth')!,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        authResponse = AuthResponse.fromJson(result);

        if (authResponse!.authError == "") {
          _box.write("authId", authResponse!.authId);
          _box.write("authUsername", "authUsername");
          _box.write("authSessionToken", authResponse!.authSessionToken);
          _box.write("authImageName", authResponse!.authImageName);
          authId = authResponse!.authId;
          authUsername = authResponse!.authUsername;
          authSessionToken.value = authResponse!.authSessionToken;
          authImageName = authResponse!.authImageName;
        } else {
          Get.snackbar("Error", authResponse!.authError,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: primaryColor);
        }
      } else {
        Get.snackbar("Error", authResponse!.authError);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  logout() {
    _box.erase();
    authSessionToken.value = "";
    authId = -1;
    authUsername = "";
    authImageName = "";
  }
}
