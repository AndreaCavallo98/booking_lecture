import 'package:badges/badges.dart';
import 'package:booking_lecture/components/custom_show_case_widget.dart';
import 'package:booking_lecture/components/top_five_teacher_card.dart';
import 'package:booking_lecture/controller/booking_controller.dart';
import 'package:booking_lecture/controller/nav_bar_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../components/section_title.dart';
import '../../../constants.dart';

class UpcomingLecture extends StatefulWidget {
  GlobalKey keyShowCase;

  UpcomingLecture({
    required this.keyShowCase,
    Key? key,
  }) : super(key: key);

  @override
  State<UpcomingLecture> createState() => _UpcomingLectureState();
}

class _UpcomingLectureState extends State<UpcomingLecture> {
  BookingController bookingController = Get.find();
  NavBarController navBarController = Get.find();
  var formatter = new DateFormat('dd/MM/yyyy');
  final keyTwo = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingController.getMyBookings("true");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SectionTitle(
            title: "Today's booked lectures ",
            pressOnSeeAll: () {},
          ),
        ),
        CustomShowCaseWidget(
          globalKey: widget.keyShowCase,
          description: "Here you'll be able to see your daily lectures",
          child: Obx(
            () => bookingController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : bookingController.myBookingListNoObs.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 180,
                              child: Lottie.network(
                                  fit: BoxFit.cover,
                                  "https://assets3.lottiefiles.com/private_files/lf30_cgfdhxgx.json"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: defaultPadding * 3),
                                child: Column(
                                  children: [
                                    Text("No lecture for today..."),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: defaultPadding),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                        onPressed: () async {
                                          navBarController.selectedIndex.value =
                                              1;
                                        },
                                        child: const Text("BOOK ONE NOW!"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            bookingController.myBookingListNoObs.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.only(left: defaultPadding),
                              child: Container(
                                width: 400,
                                padding: const EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: bookingController
                                              .myBookingListNoObs[index]
                                              .confirmed
                                          ? Colors.green.withOpacity(0.5)
                                          : bookingController
                                                  .myBookingListNoObs[index]
                                                  .deleted
                                              ? Colors.red.withOpacity(0.5)
                                              : Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                  color: Get.isDarkMode
                                      ? Color.fromARGB(255, 34, 32, 32)
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
                                              formatter.format(bookingController
                                                  .myBookingListNoObs[index]
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Badge(
                                            toAnimate: false,
                                            shape: BadgeShape.square,
                                            badgeColor: (bookingController
                                                    .myBookingListNoObs[index]
                                                    .course_color
                                                    .toColor())
                                                .withOpacity(0.8),
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
                                                            FontWeight.bold)),
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
                                                        : !bookingController
                                                                .myBookingListNoObs[
                                                                    index]
                                                                .confirmed
                                                            ? Icons
                                                                .watch_later_outlined
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
                                                      .myBookingListNoObs[index]
                                                      .deleted
                                                  ? "Deleted"
                                                  : bookingController
                                                          .myBookingListNoObs[
                                                              index]
                                                          .has_review
                                                      ? "Reviewed"
                                                      : !bookingController
                                                              .myBookingListNoObs[
                                                                  index]
                                                              .confirmed
                                                          ? " Pending..."
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
        )
      ],
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
