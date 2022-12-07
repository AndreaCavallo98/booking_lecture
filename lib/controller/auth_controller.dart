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
  var nameUsername = "";
  var authUsername = "";
  var email = "";
  var jwtToken = "".obs;
  var authImageName = "";

  AuthResponse? authResponse = null;

  checkIfIsConnected() {
    if (_box.read("jwtToken") != null) {
      authId = _box.read("authId");
      nameUsername = _box.read("nameUsername");
      authUsername = _box.read("authUsername");
      email = _box.read("email");
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
            'http://192.168.1.85:8080/Prenotazioni0_war_exploded/servlet-auth')!,
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
          _box.write("nameUsername", authResponse!.nameUsername);
          _box.write("authUsername", authResponse!.authUsername);
          _box.write("email", authResponse!.email);
          _box.write("jwtToken", authResponse!.jwtToken);
          _box.write("authImageName", authResponse!.authImageName);
          authId = authResponse!.authId;
          nameUsername = authResponse!.nameUsername;
          authUsername = authResponse!.authUsername;
          email = authResponse!.email;
          authImageName = authResponse!.authImageName;
          jwtToken.value = authResponse!.jwtToken;
          isLoading(false);
          return authResponse!;
        } else {
          isLoading(false);
          return authResponse!;
        }
      } else {
        Get.snackbar("Error", authResponse!.authError);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      return authResponse!;
    }
  }

  logout() {
    _box.remove("authId");
    _box.remove("nameUsername");
    _box.remove("authUsername");
    _box.remove("email");
    _box.remove("jwtToken");
    _box.remove("authImageName");
    jwtToken.value = "";
    authId = -1;
    nameUsername = "";
    authUsername = "";
    email = "";
    authImageName = "";
  }
}
