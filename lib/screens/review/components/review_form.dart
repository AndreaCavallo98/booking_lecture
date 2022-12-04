import 'dart:ffi';

import 'package:booking_lecture/controller/course_controller.dart';
import 'package:booking_lecture/controller/review_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Course.dart';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../constants.dart';
import '../../../models/Booking.dart';
import '../../dashboard/dashboard_screen.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final Booking booking;

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  ReviewController reviewController = Get.put(ReviewController());
  TextEditingController _reviewTitleController = TextEditingController();
  TextEditingController _reviewTextController = TextEditingController();
  double _ratingValue = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "RATE TO ${widget.booking.teacher_name_surname.toUpperCase()}",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) {
                    _ratingValue = v;
                    setState(() {});
                  },
                  starCount: 5,
                  rating: _ratingValue,
                  size: 40.0,
                  color: Colors.orange,
                  borderColor: Colors.orange,
                  spacing: 0.0),
            ),
          ),
          TextFormField(
            controller: _reviewTitleController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) {},
            decoration:
                InputDecoration(labelText: "TITLE", iconColor: primaryColor),
            cursorColor: primaryColor,
          ),
          const Padding(
            padding: EdgeInsets.all(defaultPadding * 1.5),
            child: Center(
              child: Text(
                "ADD SOME DETAILS",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 11,
            controller: _reviewTextController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                // Check if title is null
                if (_reviewTitleController.text.isEmpty) {
                  Get.snackbar(
                      "required field missing", "Review title is required",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: primaryColor.withOpacity(0.7),
                      colorText: Colors.white);
                } else {
                  Get.defaultDialog(
                      title: "",
                      content: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 200,
                            child: Lottie.network(
                                fit: BoxFit.fill,
                                'https://assets4.lottiefiles.com/packages/lf20_MeTWrj.json'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child:
                                Text("Do you want add this teacher's review?"),
                          ),
                        ],
                      ),
                      textCancel: "NO",
                      textConfirm: "YES",
                      barrierDismissible: false,
                      confirmTextColor: Colors.green,
                      cancelTextColor: textColor,
                      buttonColor: Colors.green.withOpacity(0.5),
                      onConfirm: () async {
                        await reviewController.addReview(
                            widget.booking.id,
                            _ratingValue.toInt(),
                            _reviewTitleController.text,
                            _reviewTextController.text);

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => DashBoard()),
                            (Route route) => false);

                        /*setState(() {
                          myBookingList[index].confirmed = true;

                          Get.back();
                          Get.snackbar("Lecture completed",
                              "You have completed the lesson with your teacher",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green.withOpacity(0.5));
                        });*/
                      });
                }
                // Add review to database

                // pop

                //Navigator.pop(context);
              },
              child: Text("CONFIRM REVIEW"),
            ),
          ),
        ],
      ),
    );
  }
}
