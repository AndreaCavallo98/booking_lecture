import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/screens/home/components/top_five_teacher.dart';
import 'package:booking_lecture/screens/home/components/upcoming_lecture.dart';
import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import '../../components/section_title.dart';
import 'components/courses.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(
                text: "Find Your",
                title: "Teacher",
              ),
              UpcomingLecture(),
              Courses(),
              TopFiveTeacher(),
            ],
          ),
        ),
      ),
    );
  }
}
