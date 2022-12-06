import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => authController
                .logout() /*Navigator.push(
              authController.logout();


              context,
              MaterialPageRoute(
                builder: (context) => /*SettingsScreen()*/ Container(),
              ),
            )*/
            ,
            icon: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultPadding / 2)),
              child: Image.asset(
                "assets/images/user_pic.png",
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(height: defaultPadding),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: "Anwar Abir",
                    decoration: inputDecoration.copyWith(hintText: "Name"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: "test@gmail.com",
                      decoration: inputDecoration.copyWith(hintText: "Email"),
                    ),
                  ),
                  TextFormField(
                    initialValue: "+88019389898",
                    decoration:
                        inputDecoration.copyWith(hintText: "Phone Number"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: "Rampura, Banasree",
                      decoration: inputDecoration.copyWith(hintText: "Address"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
);
