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
    print("aAAA");
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
                  : bookingController.myBookingList.isEmpty
                      ? Container(
                          child: const Center(
                              child: Text(
                                  "No lecture finded for now...book one now!")),
                        )
                      : Column(
                          children: List.generate(
                            bookingController.myBookingList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Slidable(
                                enabled: !bookingController
                                        .myBookingList[index].deleted &&
                                    !(bookingController
                                            .myBookingList[index].confirmed &&
                                        bookingController
                                            .myBookingList[index].has_review),
                                startActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: bookingController
                                              .myBookingList[index].date
                                              .compareTo(DateTime.now()) >
                                          0
                                      ? []
                                      : [
                                          !bookingController
                                                  .myBookingList[index]
                                                  .confirmed
                                              ? SlidableAction(
                                                  backgroundColor: Colors.green
                                                      .withOpacity(0.75),
                                                  icon: Icons.verified,
                                                  label: "Mark as done",
                                                  onPressed: (context) => {
                                                    // => TO DO: marked as done
                                                  },
                                                )
                                              : Container(),
                                          bookingController.myBookingList[index]
                                                  .confirmed
                                              ? SlidableAction(
                                                  backgroundColor: Colors.white,
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
                                          .myBookingList[index].confirmed
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
                                                                .myBookingList[
                                                                    index]
                                                                .id);
                                                    Get.back();
                                                    Get.snackbar(
                                                        "Booking deleted",
                                                        "Your booking has been deleted correctly",
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        backgroundColor: Colors
                                                            .red
                                                            .withOpacity(0.5));
                                                  })
                                            },
                                          )
                                        ],
                                ),
                                child: Opacity(
                                  opacity: bookingController
                                              .myBookingList[index].deleted ||
                                          (bookingController
                                                  .myBookingList[index]
                                                  .confirmed &&
                                              bookingController
                                                  .myBookingList[index]
                                                  .has_review)
                                      ? 0.7
                                      : 1,
                                  child: Container(
                                    padding: EdgeInsets.all(defaultPadding),
                                    decoration: BoxDecoration(
                                      color: bookingController
                                              .myBookingList[index].deleted
                                          ? Colors.red.withOpacity(0.4)
                                          : Colors.white,
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
                                                          .myBookingList[index]
                                                          .date)),
                                            ),
                                            Expanded(
                                              child: buildAppointmentInfo(
                                                  "Time slot",
                                                  "${bookingController.myBookingList[index].start_time} - ${bookingController.myBookingList[index].end_time}"),
                                            ),
                                            Expanded(
                                              child: buildAppointmentInfo(
                                                  "Teacher",
                                                  bookingController
                                                      .myBookingList[index]
                                                      .teacher_name_surname),
                                            ),
                                          ],
                                        ),
                                        Divider(height: defaultPadding),
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
                                                    .myBookingList[index]
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
                                                            .myBookingList[
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
                                                            .myBookingList[
                                                                index]
                                                            .deleted
                                                        ? Icons.delete
                                                        : bookingController
                                                                .myBookingList[
                                                                    index]
                                                                .has_review
                                                            ? Icons.star
                                                            : Icons
                                                                .star_outline_outlined,
                                                    color: bookingController
                                                            .myBookingList[
                                                                index]
                                                            .has_review
                                                        ? Color.fromARGB(
                                                            255, 239, 168, 74)
                                                        : Colors.black,
                                                  ),
                                                  Text(bookingController
                                                          .myBookingList[index]
                                                          .deleted
                                                      ? "Deleted"
                                                      : bookingController
                                                              .myBookingList[
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
