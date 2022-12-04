import 'package:badges/badges.dart';
import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/Booking.dart';
import 'components/review_form.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text("Review your lecture"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultPadding / 2)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: buildAppointmentInfo(
                              "Date", formatter.format(booking.date)),
                        ),
                        Expanded(
                          child: buildAppointmentInfo("Time slot",
                              "${booking.start_time} - ${booking.end_time}"),
                        ),
                        Expanded(
                          child: buildAppointmentInfo(
                              "Teacher", booking.teacher_name_surname),
                        ),
                      ],
                    ),
                    Divider(height: 30),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Badge(
                            toAnimate: false,
                            shape: BadgeShape.square,
                            badgeColor: (booking.course_color.toColor()),
                            borderRadius: BorderRadius.circular(8),
                            badgeContent: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(booking.course_title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: defaultPadding),
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultPadding / 2)),
                ),
                child: ReviewForm(
                  booking: booking,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column buildAppointmentInfo(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withOpacity(0.62),
          ),
        ),
        Text(
          text,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
