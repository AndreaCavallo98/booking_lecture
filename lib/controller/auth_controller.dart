import 'dart:convert';

import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/models/AuthResponse.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

//gio.pasche ti amo <3
class AuthController extends GetxController {
  var isLoading = false.obs;
  final _box = GetStorage();
  NavBarController navBarController = Get.put(NavBarController());

  var authId = -1;
  var authUsername = "";
  var jwtToken = "".obs;
  var authImageName = "";

  AuthResponse? authResponse = null;

  checkIfIsConnected() {
    print(_box.read("jwtToken"));
    if (_box.read("jwtToken") != null) {
      authId = _box.read("authId");
      authUsername = _box.read("authUsername");
      jwtToken.value = _box.read("jwtToken");
      authImageName = _box.read("authImageName");
    }
  }

  // => Manage jwt authentication

  Future<AuthResponse> login(String username, String password) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.tryParse(
            'http://192.168.1.8:8080/Prenotazioni0_war_exploded/servlet-auth')!,
        //'http://localhost:8080/Prenotazioni0_war_exploded/servlet-auth')!,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        authResponse = AuthResponse.fromJson(result);

        if (authResponse!.authError == "") {
          navBarController.selectedIndex.value = 0;
          _box.write("authId", authResponse!.authId);
          _box.write("authUsername", authResponse!.authUsername);
          _box.write("jwtToken", authResponse!.jwtToken);
          _box.write("authImageName", authResponse!.authImageName);
          authId = authResponse!.authId;
          authUsername = authResponse!.authUsername;
          jwtToken.value = authResponse!.jwtToken;
          authImageName = authResponse!.authImageName;
          return authResponse!;
        } else {
          return authResponse!;
        }
      } else {
        Get.snackbar("Error", authResponse!.authError);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      return authResponse!;
      isLoading(false);
    }
  }

  logout() {
    _box.erase();
    jwtToken.value = "";
    authId = -1;
    authUsername = "";
    authImageName = "";
  }
}
