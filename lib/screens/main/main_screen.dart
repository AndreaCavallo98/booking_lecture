import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/screens/auth/sign_in_screen.dart';
import 'package:booking_lecture/screens/teacher/teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constants.dart';
import '../home/home_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  NavBarController navBarController = Get.put(NavBarController());
  TeacherController teacherController = Get.put(TeacherController());
  AuthController authController = Get.put(AuthController());

  final List<Widget> _pages = [
    HomePage(),
    const TeacherScreen(),
    Container(),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.authToken != ""
          ? SignInScreen()
          : Scaffold(
              body: _pages[navBarController.selectedIndex.value],
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(defaultPadding),
                color: Colors.white,
                child: SafeArea(
                  child: GNav(
                    haptic: true,
                    tabBorderRadius: 15,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 350),
                    gap: 8,
                    color: Colors.grey[800],
                    activeColor: Colors.white,
                    iconSize: 24,
                    selectedIndex: navBarController.selectedIndex.value,
                    tabBackgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding / 2,
                    ),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                        active: navBarController.selectedIndex.value == 0,
                      ),
                      GButton(
                        icon: Icons.people,
                        text: 'Teachers',
                        active: navBarController.selectedIndex.value == 1,
                      ),
                      GButton(
                        icon: Icons.content_paste,
                        text: 'My booking',
                        active: navBarController.selectedIndex.value == 2,
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                        active: navBarController.selectedIndex.value == 3,
                      )
                    ],
                    onTabChange: (pageNum) {
                      navBarController.changePageIndex(pageNum);
                      teacherController.filterCourseId = -1;
                      teacherController.filterDate = "";
                      teacherController.filterMaxHourlyRate = 0;
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
