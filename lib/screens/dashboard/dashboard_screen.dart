import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/screens/auth/sign_in_screen.dart';
import 'package:booking_lecture/screens/teacher/teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constants.dart';
import '../../controller/booking_controller.dart';
import '../booking/my_booking_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile/profile_screen.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);

  NavBarController navBarController = Get.find();
  TeacherController teacherController = Get.put(TeacherController());
  BookingController bookingController = Get.put(BookingController());
  AuthController authController = Get.find();

  final List<Widget> _pages = [
    HomePage(),
    const TeacherScreen(),
    MyBookingScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _pages[navBarController.selectedIndex.value],
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(defaultPadding),
          color:
              Get.isDarkMode ? Color.fromARGB(255, 34, 32, 32) : Colors.white,
          child: SafeArea(
            child: GNav(
              haptic: true,
              tabBorderRadius: 15,
              curve: Curves.ease,
              duration: Duration(milliseconds: 350),
              gap: 8,
              color: Get.isDarkMode
                  ? Color.fromARGB(255, 189, 183, 183)
                  : Colors.grey[800],
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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "assets/images/user_pic.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  icon: Icons.person,
                  text: 'Profile',
                  active: navBarController.selectedIndex.value == 3,
                )
              ],
              onTabChange: (pageNum) async {
                navBarController.changePageIndex(pageNum);
                teacherController.filterCourseId = -1;
                teacherController.filterDate = "";
                teacherController.filterMaxHourlyRate = 0;
                teacherController.searchInput = "";
              },
            ),
          ),
        ),
      ),
    );
  }
}
