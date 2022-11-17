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
    reviewController.fetchData(widget.idTeacher);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SectionTitle(
            title: "Reviews",
            pressOnSeeAll: () {},
          ),
        ),
        Obx(
          () => reviewController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : reviewController.reviewList.isEmpty
                  ? Container(
                      child: Center(child: Text("No reviews yet")),
                    )
                  : SizedBox(
                      height: 700,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviewController.reviewList.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(
                            image: "assets/images/Serena_Gome.png",
                            name:
                                "${reviewController.reviewList[index].user_name} ${reviewController.reviewList[index].user_surname}",
                            date: reviewController
                                .reviewList[index].creation_date,
                            comment: reviewController.reviewList[index].text,
                            rating: reviewController.reviewList[index].rate,

                            /*onTap: () => setState(() {
                  isMore = !isMore;
                }),
                isLess: isMore,*/
                          );
                        },
                      )),
        ),
      ],
    );
  }
}
