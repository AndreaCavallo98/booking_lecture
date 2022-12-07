import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import '../../services/theme_services.dart';
import '../dashboard/dashboard_screen.dart';
import 'components/setting_item_caed.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthController authController = Get.find();
  NavBarController navBarController = Get.find();
  bool darkMode = false;
  final _box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    darkMode = ThemeService().loadThemeFromBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              SettingTab(
                text: "Notifications",
                icon: Icon(
                  Icons.notification_important,
                  color: primaryColor,
                ),
                value: true,
                onChanged: (value) {},
              ),
              SettingTab(
                text: "Dark mode",
                icon: Icon(
                  Icons.dark_mode,
                  color: primaryColor,
                ),
                value: darkMode,
                onChanged: (value) {
                  ThemeService().switchTheme();

                  setState(() {
                    darkMode = value;
                  });
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (route) => false,
                  );
                },
              ),
              SettingTab(
                text: "Select language",
                icon: Icon(
                  Icons.language,
                  color: primaryColor,
                ),
                value: true,
                onChanged: (value) {},
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              child: Lottie.network(
                                  fit: BoxFit.fill,
                                  'https://assets9.lottiefiles.com/packages/lf20_8fX6Mejkd5.json'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Text(
                                  "Are you sure to continue? you will be logged out of your account! "),
                            ),
                          ],
                        ),
                        textCancel: "NO",
                        textConfirm: "YES",
                        barrierDismissible: false,
                        confirmTextColor: Color.fromARGB(255, 209, 51, 39),
                        cancelTextColor: textColor,
                        buttonColor: Colors.red.withOpacity(0.5),
                        onConfirm: () async {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          await authController.logout();
                        });
                  },
                  child: Text("LOGOUT"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
