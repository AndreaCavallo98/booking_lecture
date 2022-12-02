import 'package:badges/badges.dart';
import 'package:booking_lecture/controller/booking_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import '../dashboard/dashboard_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  static final DateTime _date = DateTime.now();

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  BookingController bookingController = Get.find();
  var formatter = new DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingController.getMyBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Bookings"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Obx(
              () => bookingController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : bookingController.myBookingListNoObs.isEmpty
                      ? Container(
                          child: const Center(
                              child: Text(
                                  "No lecture finded for now...book one now!")),
                        )
                      : Column(
                          children: List.generate(
                            bookingController.myBookingListNoObs.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Slidable(
                                enabled: !bookingController
                                        .myBookingListNoObs[index].deleted &&
                                    !(bookingController
                                            .myBookingListNoObs[index]
                                            .confirmed &&
                                        bookingController
                                            .myBookingListNoObs[index]
                                            .has_review),
                                startActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: bookingController
                                              .myBookingListNoObs[index].date
                                              .compareTo(DateTime.now()) >
                                          0
                                      ? []
                                      : [
                                          !bookingController
                                                  .myBookingListNoObs[index]
                                                  .confirmed
                                              ? SlidableAction(
                                                  backgroundColor: Colors.green
                                                      .withOpacity(0.75),
                                                  icon: Icons.verified,
                                                  label: "Mark as done",
                                                  onPressed: (context) => {
                                                    Get.defaultDialog(
                                                        title: "",
                                                        content: Column(
                                                          children: [
                                                            Container(
                                                              height: 150,
                                                              width: 150,
                                                              child: Lottie.network(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  'https://assets8.lottiefiles.com/packages/lf20_7htpyk2w.json'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      defaultPadding),
                                                              child: Text(
                                                                  "You have finished the lesson with ${bookingController.myBookingListNoObs[index].teacher_name_surname}? Then you'll be able to review your teacher!"),
                                                            ),
                                                          ],
                                                        ),
                                                        textCancel: "NO",
                                                        textConfirm:
                                                            "COMPLETED",
                                                        barrierDismissible:
                                                            false,
                                                        confirmTextColor:
                                                            Colors.green,
                                                        cancelTextColor:
                                                            textColor,
                                                        buttonColor: Colors
                                                            .green
                                                            .withOpacity(0.5),
                                                        onConfirm: () async {
                                                          await bookingController
                                                              .markAsDoneBooking(
                                                                  bookingController
                                                                      .myBookingListNoObs[
                                                                          index]
                                                                      .id);

                                                          setState(() {
                                                            bookingController
                                                                .myBookingListNoObs[
                                                                    index]
                                                                .confirmed = true;

                                                            Get.back();
                                                            Get.snackbar(
                                                                "Lecture completed",
                                                                "You have completed the lesson with your teacher",
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .TOP,
                                                                backgroundColor:
                                                                    Colors.green
                                                                        .withOpacity(
                                                                            0.5));
                                                          });
                                                        })
                                                  },
                                                )
                                              : Container(),
                                          bookingController
                                                  .myBookingListNoObs[index]
                                                  .confirmed
                                              ? SlidableAction(
                                                  backgroundColor: primaryColor
                                                      .withOpacity(0.8),
                                                  icon: Icons.star,
                                                  label: "review",
                                                  onPressed: (context) => {
                                                    // => TO DO: review lecture
                                                  },
                                                )
                                              : Container()
                                        ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: bookingController
                                          .myBookingListNoObs[index].confirmed
                                      ? []
                                      : [
                                          SlidableAction(
                                            backgroundColor:
                                                Colors.red.withOpacity(0.75),
                                            icon: Icons.delete,
                                            label: "Delete",
                                            onPressed: (context) => {
                                              Get.defaultDialog(
                                                  title: "",
                                                  content: Column(
                                                    children: [
                                                      Container(
                                                        height: 150,
                                                        width: 150,
                                                        child: Lottie.network(
                                                            fit: BoxFit.fill,
                                                            'https://assets10.lottiefiles.com/packages/lf20_d6r9tuqy.json'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(
                                                                defaultPadding),
                                                        child: Text(
                                                            "Do you want delete the booking?"),
                                                      ),
                                                    ],
                                                  ),
                                                  textCancel: "NO",
                                                  textConfirm: "DELETE",
                                                  barrierDismissible: false,
                                                  confirmTextColor:
                                                      Color.fromARGB(
                                                          255, 209, 51, 39),
                                                  cancelTextColor: textColor,
                                                  buttonColor: Colors.red
                                                      .withOpacity(0.5),
                                                  onConfirm: () async {
                                                    await bookingController
                                                        .deleteBooking(
                                                            bookingController
                                                                .myBookingListNoObs[
                                                                    index]
                                                                .id);

                                                    setState(() {
                                                      bookingController
                                                          .myBookingListNoObs[
                                                              index]
                                                          .deleted = true;

                                                      Get.back();
                                                      Get.snackbar(
                                                          "Booking deleted",
                                                          "Your booking has been deleted correctly",
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          backgroundColor:
                                                              Colors.red
                                                                  .withOpacity(
                                                                      0.5));
                                                    });
                                                  })
                                            },
                                          )
                                        ],
                                ),
                                child: Opacity(
                                  opacity: bookingController
                                              .myBookingListNoObs[index]
                                              .deleted ||
                                          (bookingController
                                                  .myBookingListNoObs[index]
                                                  .confirmed &&
                                              bookingController
                                                  .myBookingListNoObs[index]
                                                  .has_review)
                                      ? 0.7
                                      : 1,
                                  child: Container(
                                    padding: EdgeInsets.all(defaultPadding),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: /*bookingController
                                              .myBookingListNoObs[index].deleted
                                          ? Color.fromARGB(255, 229, 123, 116)
                                              .withOpacity(0.3)
                                          : bookingController
                                                  .myBookingListNoObs[index]
                                                  .confirmed
                                              ? Color.fromARGB(
                                                      255, 141, 240, 144)
                                                  .withOpacity(0.3)
                                              :*/
                                          Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(defaultPadding / 2)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: buildAppointmentInfo(
                                                  "Date",
                                                  formatter.format(
                                                      bookingController
                                                          .myBookingListNoObs[
                                                              index]
                                                          .date)),
                                            ),
                                            Expanded(
                                              child: buildAppointmentInfo(
                                                  "Time slot",
                                                  "${bookingController.myBookingListNoObs[index].start_time} - ${bookingController.myBookingListNoObs[index].end_time}"),
                                            ),
                                            Expanded(
                                              child: buildAppointmentInfo(
                                                  "Teacher",
                                                  bookingController
                                                      .myBookingListNoObs[index]
                                                      .teacher_name_surname),
                                            ),
                                          ],
                                        ),
                                        Divider(height: 30),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Badge(
                                                toAnimate: false,
                                                shape: BadgeShape.square,
                                                badgeColor: (bookingController
                                                    .myBookingListNoObs[index]
                                                    .course_color
                                                    .toColor()),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                badgeContent: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                        bookingController
                                                            .myBookingListNoObs[
                                                                index]
                                                            .course_title,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    bookingController
                                                            .myBookingListNoObs[
                                                                index]
                                                            .deleted
                                                        ? Icons.delete
                                                        : bookingController
                                                                .myBookingListNoObs[
                                                                    index]
                                                                .has_review
                                                            ? Icons.star
                                                            : Icons
                                                                .star_outline_outlined,
                                                    color: bookingController
                                                            .myBookingListNoObs[
                                                                index]
                                                            .has_review
                                                        ? Color.fromARGB(
                                                            255, 239, 168, 74)
                                                        : bookingController
                                                                .myBookingListNoObs[
                                                                    index]
                                                                .deleted
                                                            ? Colors.red
                                                            : Colors.black,
                                                  ),
                                                  Text(bookingController
                                                          .myBookingListNoObs[
                                                              index]
                                                          .deleted
                                                      ? "Deleted"
                                                      : bookingController
                                                              .myBookingListNoObs[
                                                                  index]
                                                              .has_review
                                                          ? "Reviewed"
                                                          : "missing review"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
          ),
        ));
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
