import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/screens/teacher/components/teacher_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  TeacherController teacherController = Get.put(TeacherController());

  @override
  void initState() {
    super.initState();
    teacherController.getTeacher("all");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(text: "Teachers", title: "All"),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Obx(
                  () => teacherController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: teacherController.teacherList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) => TeacherCard(
                            teacher: teacherController.teacherList[index],
                            press: () => {},
                            // press: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DoctorDetailsScreen(),
                            //   ),
                            // ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
