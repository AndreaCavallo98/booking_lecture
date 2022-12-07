import 'package:booking_lecture/screens/auth/introduction_screen.dart';
import 'package:booking_lecture/screens/dashboard/dashboard_screen.dart';
import 'package:booking_lecture/services/theme_services.dart';
import 'package:booking_lecture/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_theme_dark.dart';
import 'controller/auth_controller.dart';
import 'screens/main/main_screen.dart';

bool showIntroduction = true;

void main() async {
  var getStorage = await GetStorage.init();
  final _box = GetStorage();
  showIntroduction = _box.read("ON_BOARDING") ?? true;
  runApp(MyApp());
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.light,
      themeMode: ThemeService().theme,
      darkTheme: Themes.dark,
      debugShowCheckedModeBanner: false,
      home: showIntroduction ? IntroScreen() : const MainScreen(),
    );
  }
}
