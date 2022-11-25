import 'package:booking_lecture/controller/course_controller.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Course.dart';
import 'package:booking_lecture/screens/teacher/teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/section_title.dart';
import '../../../constants.dart';

class Courses extends StatefulWidget {
  Courses({
    Key? key,
  }) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  CourseController courseController = Get.put(CourseController());
  NavBarController navBarController = Get.find();
  TeacherController teacherController = Get.put(TeacherController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseController.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SectionTitle(
            title: "What you want to learn?",
            pressOnSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => courseController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: List.generate(
                      courseController.courseList.length,
                      (index) => CourseCard(
                        course: courseController.courseList[index],
                        press: () {
                          navBarController.changePageIndex(1);
                          teacherController.filterCourseId =
                              courseController.courseList[index].id!;
                        },
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
    required this.press,
  }) : super(key: key);

  final Course course;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding),
      child: InkWell(
        onTap: press,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: course.color!.toColor(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/Psychiatrist.svg"),
              SizedBox(height: defaultPadding / 2),
              Text(
                course.title ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
