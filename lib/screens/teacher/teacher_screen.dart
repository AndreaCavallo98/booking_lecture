import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/models/Course.dart';
import 'package:booking_lecture/screens/details/teacher_details_screen.dart';
import 'package:booking_lecture/screens/teacher/components/teacher_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../models/Teacher.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  TeacherController teacherController = Get.find();
  final searchController = TextEditingController();
  //String searchInput = te;

  @override
  void initState() {
    super.initState();
    searchController.text = teacherController.searchInput;
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
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search name or course...',
                      border: OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: primaryColor))),
                  onChanged: ((value) {
                    setState(() {
                      teacherController.searchInput = value;
                    });
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Obx(() => teacherController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : teacherController.getTeacherList().isEmpty
                        ? Container(
                            child: const Center(
                                child: Text(
                                    "No teacher finded with your requirement, try to change filter")),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                teacherController.getTeacherList().length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) => TeacherCard(
                              teacher:
                                  teacherController.getTeacherList()[index],
                              press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TeacherDetailsScreen(
                                    selectedTeacher: teacherController
                                        .getTeacherList()[index],
                                  ),
                                ),
                              ),
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
