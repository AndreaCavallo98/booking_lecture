import 'package:booking_lecture/controller/course_controller.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/controller/review_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Course.dart';
import 'package:booking_lecture/screens/details/components/review_card.dart';
import 'package:booking_lecture/screens/teacher/teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/section_title.dart';
import '../../../constants.dart';

class Reviews extends StatefulWidget {
  Reviews({
    Key? key,
    required this.idTeacher,
  }) : super(key: key);

  int idTeacher;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  ReviewController reviewController = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reviewController.fetchData(widget.idTeacher);
    });
    //print(widget.idTeacher);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => reviewController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : reviewController.reviewList.isEmpty
              ? Container(
                  child: Center(child: Text("No reviews yet")),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: Row(
                        children: List.generate(
                            reviewController.reviewList.length,
                            (index) => Container(
                                  width: 300,
                                  height: 160,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: defaultPadding,
                                      ),
                                      child: ReviewCard(
                                        image: "assets/images/Serena_Gome.png",
                                        name:
                                            "${reviewController.reviewList[index].user_name} ${reviewController.reviewList[index].user_surname}",
                                        date: reviewController
                                            .reviewList[index].creation_date,
                                        comment: reviewController
                                            .reviewList[index].text,
                                        rating: reviewController
                                            .reviewList[index].rate,
                                      )),
                                ))),
                  ),
                ),
    );
  }
}
