import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/screens/auth/sign_in_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../dashboard/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.checkIfIsConnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        authController.authSessionToken == "" ? SignInScreen() : DashBoard());
  }
}
