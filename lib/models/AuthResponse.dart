import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthResponse {
  late int authId;
  late String authUsername;
  late String jwtToken;
  late String authImageName;
  late String authError;

  AuthResponse(
      {required this.authId,
      required this.authUsername,
      required this.jwtToken,
      required this.authImageName,
      required this.authError});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    authId = json['authId'];
    authUsername = json['authUsername'];
    jwtToken = json['jwtToken'];
    authImageName = json['authImageName'];
    authError = json['authError'];
  }
}
