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
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../constants.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
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
              "RATE TO",
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
                } else {}
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
