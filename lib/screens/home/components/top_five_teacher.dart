import 'package:booking_lecture/components/top_five_teacher_card.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/section_title.dart';
import '../../../constants.dart';

class TopFiveTeacher extends StatefulWidget {
  const TopFiveTeacher({
    Key? key,
  }) : super(key: key);

  @override
  State<TopFiveTeacher> createState() => _TopFiveTeacherState();
}

class _TopFiveTeacherState extends State<TopFiveTeacher> {
  TeacherController teacherController = Get.put(TeacherController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      teacherController.getTeacher("topfive");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SectionTitle(
            title: "Top 5 reviewed teacher",
            pressOnSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => teacherController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: List.generate(
                      teacherController.teacherList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: defaultPadding),
                        child: TopFiveTeacherCard(
                          teacher: teacherController.teacherList[index],
                        ),
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
