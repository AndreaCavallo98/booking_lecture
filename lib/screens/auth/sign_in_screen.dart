import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/screens/auth/sign_up_screen.dart';
import 'package:booking_lecture/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import 'components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign In",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              Container(
                  child: Lottie.asset("assets/lottie/login_orange.json",
                      fit: BoxFit.cover)),
              Row(
                children: [
                  Text("Don’n have an account?"),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    ),
                    child: Text("Sign up!"),
                  )
                ],
              ),
              SizedBox(height: defaultPadding * 1.5),
              SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}
