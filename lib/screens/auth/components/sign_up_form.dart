import 'package:booking_lecture/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/auth_controller.dart';
import '../../../models/AuthResponse.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    String _password = "";
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: RequiredValidator(errorText: requiredField),
            onSaved: (newValue) {},
            decoration: InputDecoration(labelText: "Name*"),
            controller: _nameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: RequiredValidator(errorText: requiredField),
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) {},
              decoration: InputDecoration(labelText: "Surname*"),
              controller: _surnameController,
            ),
          ),
          TextFormField(
            validator: RequiredValidator(errorText: requiredField),
            onSaved: (newValue) {},
            decoration: InputDecoration(labelText: "Username*"),
            controller: _usernameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: requiredField),
                  EmailValidator(errorText: emailError),
                ],
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) {},
              decoration: InputDecoration(labelText: "Email*"),
              controller: _emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: passwordValidator,
              obscureText: true,
              onChanged: (value) => _password = value,
              onSaved: (pass) {},
              decoration: InputDecoration(labelText: "Password*"),
              controller: _passwordController,
            ),
          ),
          TextFormField(
            validator: (val) =>
                MatchValidator(errorText: 'passwords do not match')
                    .validateMatch(val!, _password),
            obscureText: true,
            onSaved: (newValue) {},
            decoration: InputDecoration(labelText: "Confirm password*"),
          ),
          SizedBox(height: defaultPadding * 1.5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthResponse authResponse = await authController.register(
                    _nameController.text,
                    _surnameController.text,
                    _usernameController.text,
                    _emailController.text,
                    _passwordController.text,
                  );

                  if (authResponse.authError == "") {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        (Route route) => false);
                    // Navigator.of(context).pop();
                  } else {
                    Get.snackbar("Registration Error", authResponse.authError,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: primaryColor);
                  }
                }
              },
              child: Text("Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}
