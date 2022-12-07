import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthResponse {
  late int authId;
  late String nameUsername;
  late String authUsername;
  late String email;
  late String jwtToken;
  late String authImageName;
  late String authError;

  AuthResponse(
      {required this.authId,
      required this.nameUsername,
      required this.authUsername,
      required this.email,
      required this.jwtToken,
      required this.authImageName,
      required this.authError});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    authId = json['authId'];
    nameUsername = json['nameUsername'];
    authUsername = json['authUsername'];
    email = json['email'];
    jwtToken = json['jwtToken'];
    authImageName = json['authImageName'];
    authError = json['authError'];
  }
}
