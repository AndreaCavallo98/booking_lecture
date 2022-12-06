//import 'package:doctor/screens/home/home_screen.dart';
//import 'package:doctor/screens/main/main_screen.dart';
import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/models/AuthResponse.dart';
import 'package:booking_lecture/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
//import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

class SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _usernameController,
            validator: MultiValidator(
              [
                RequiredValidator(errorText: requiredField),
              ],
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) {},
            decoration: InputDecoration(labelText: "Username*"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              validator: passwordValidator,
              obscureText: true,
              onSaved: (newValue) {},
              decoration: InputDecoration(labelText: "Password*"),
            ),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                print("PREMUTO");
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  AuthResponse authResponse = await authController.login(
                      _usernameController.text, _passwordController.text);

                  if (authResponse.authError == "") {
                    /*Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => DashBoard()),
                        (Route route) => false);*/
                    // Navigator.of(context).pop();
                  } else {
                    Get.snackbar("Authentication Error", authResponse.authError,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: primaryColor);
                  }
                }
              },
              child: Text("Sign In"),
            ),
          ),
        ],
      ),
    );
  }
}
