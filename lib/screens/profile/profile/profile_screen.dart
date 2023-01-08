import 'package:booking_lecture/components/custom_show_case_widget.dart';
import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../constants.dart';
import '../../settings/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.find();
  GlobalKey keySettings = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _box = GetStorage();
      bool showCaseHomePage = await _box.read("SHOWCASE_PROFILE");
      if (showCaseHomePage == null) {
        ShowCaseWidget.of(context).startShowCase([keySettings]);
        _box.write("SHOWCASE_PROFILE", false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Get.isDarkMode ? Colors.white : textColor),
        ),
        actions: [
          CustomShowCaseWidget(
            globalKey: keySettings,
            description: "Tap here to update the application settings",
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              ),
              icon: Icon(
                Icons.settings,
                color: primaryColor,
              ),
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
                    enabled: false,
                    readOnly: true,
                    initialValue: authController.nameUsername,
                    decoration: inputDecoration.copyWith(
                        labelText: "Name & Surname",
                        fillColor: Get.isDarkMode
                            ? Color.fromARGB(255, 34, 32, 32)
                            : Colors.white,
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      enabled: false,
                      readOnly: true,
                      initialValue: authController.authUsername,
                      decoration: inputDecoration.copyWith(
                          fillColor: Get.isDarkMode
                              ? Color.fromARGB(255, 34, 32, 32)
                              : Colors.white,
                          labelText: "Username",
                          labelStyle: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    initialValue: authController.email,
                    decoration: inputDecoration.copyWith(
                        fillColor: Get.isDarkMode
                            ? Color.fromARGB(255, 34, 32, 32)
                            : Colors.white,
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
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
