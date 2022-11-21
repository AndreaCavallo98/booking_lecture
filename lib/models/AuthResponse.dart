import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthResponse {
  late int authId;
  late String authUsername;
  late String authSessionToken;
  late String authImageName;
  late String authError;

  AuthResponse(
      {required this.authId,
      required this.authUsername,
      required this.authSessionToken,
      required this.authImageName,
      required this.authError});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    authId = json['authId'];
    authUsername = json['authUsername'];
    authSessionToken = json['authSessionToken'];
    authImageName = json['authImageName'];
    authError = json['authError'];
  }
}
