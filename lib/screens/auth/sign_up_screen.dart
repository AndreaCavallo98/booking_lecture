import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import 'components/sign_up_form.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  Container(
                      height: 150,
                      width: 180,
                      child: Lottie.asset("assets/lottie/login_orange.json",
                          fit: BoxFit.cover)),
                ],
              ),
              Row(
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Sign In!"),
                  )
                ],
              ),
              SizedBox(height: defaultPadding * 1.5),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
