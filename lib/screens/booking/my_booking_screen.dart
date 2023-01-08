import 'package:badges/badges.dart';
import 'package:booking_lecture/components/custom_show_case_widget.dart';
import 'package:booking_lecture/controller/booking_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/screens/review/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../constants.dart';
import '../../models/Booking.dart';
import '../../services/notification_service.dart';
import '../dashboard/dashboard_screen.dart';
import '../search/search_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  static final DateTime _date = DateTime.now();

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  BookingController bookingController = Get.find();
  List<Booking> myBookingList = <Booking>[];
  NotificationServices notificationServices = Get.find();
  var formatter = new DateFormat('dd/MM/yyyy');
  bool hideDeleted = true;
  bool hideArchived = true;

  GlobalKey keyFirstBooking = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bookingController.getMyBookings("false");
      myBookingList =
          bookingController.getMyBookingList(hideDeleted, hideArchived);

      final _box = GetStorage();
      bool showCaseHomePage = await _box.read("SHOWCASE_BOOKING");
      if (showCaseHomePage == null) {
        if (myBookingList.length > 0) {
          ShowCaseWidget.of(context).startShowCase([keyFirstBooking]);
          _box.write("SHOWCASE_BOOKING", false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Bookings",
            style: TextStyle(color: Get.isDarkMode ? Colors.white : textColor),
          ),
          actions: [
            Row(
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: hideDeleted ? Colors.grey : Colors.red,
                  ),
                  label: Text(
                    'deleted',
                    style: TextStyle(
                        color: hideDeleted ? Colors.grey : Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      hideDeleted = !hideDeleted;
                      myBookingList = bookingController.getMyBookingList(
                          hideDeleted, hideArchived);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.history_outlined,
                      color: hideArchived ? Colors.grey : Colors.green,
                    ),
                    label: Text(
                      'archived',
                      style: TextStyle(
                          color: hideArchived ? Colors.grey : Colors.green),
                    ),
                    onPressed: () {
                      setState(() {
                        hideArchived = !hideArchived;
                        myBookingList = bookingController.getMyBookingList(
                            hideDeleted, hideArchived);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Obx(
              () => bookingController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : myBookingList.isEmpty
                      ? Container(
                          child: const Center(
                              child: Text(
                                  "No lecture finded for now...book one now!")),
                        )
                      : CustomShowCaseWidget(
                          description:
                              "swipe left a booking to delete it. When the lecture time has passed swipe right on the booking to confirm it. Finally swipe left again to make a review",
                          globalKey: keyFirstBooking,
                          child: Column(
                            children: List.generate(
                              myBookingList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: defaultPadding),
                                child: Slidable(
                                  enabled: !myBookingList[index].deleted &&
                                      !(myBookingList[index].confirmed &&
                                          myBookingList[index].has_review),
                                  startActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: myBookingList[index]
                                                .date
                                                .add(Duration(
                                                    hours: myBookingList[index]
                                                        .end_time))
                                                .compareTo(DateTime.now()) >
                                            0
                                        ? []
                                        : [
                                            !myBookingList[index].confirmed
                                                ? SlidableAction(
                                                    backgroundColor: Colors
                                                        .green
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
                                                                padding: const EdgeInsets
                                                                        .all(
                                                                    defaultPadding),
                                                                child: Text(
                                                                    "You have finished the lesson with ${myBookingList[index].teacher_name_surname}? Then you'll be able to review your teacher!"),
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
                                                                    myBookingList[
                                                                            index]
                                                                        .id);

                                                            setState(() {
                                                              myBookingList[
                                                                          index]
                                                                      .confirmed =
                                                                  true;

                                                              Get.back();
                                                              Get.snackbar(
                                                                  "Lecture completed",
                                                                  "You have completed the lesson with your teacher",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .TOP,
                                                                  backgroundColor: Colors
                                                                      .green
                                                                      .withOpacity(
                                                                          0.5));
                                                            });
                                                          })
                                                    },
                                                  )
                                                : Container(),
                                            myBookingList[index].confirmed
                                                ? SlidableAction(
                                                    backgroundColor:
                                                        Get.isDarkMode
                                                            ? Colors.black
                                                            : Colors.white,
                                                    foregroundColor:
                                                        Colors.orange,
                                                    icon: Icons.star,
                                                    label: "write review",
                                                    onPressed: (context) => {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReviewScreen(
                                                                  booking:
                                                                      myBookingList[
                                                                          index]),
                                                        ),
                                                      ),
                                                    },
                                                  )
                                                : Container()
                                          ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: myBookingList[index].confirmed
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
                                                              myBookingList[
                                                                      index]
                                                                  .id);

                                                      notificationServices
                                                          .cancelScheduleNotification(
                                                              myBookingList[
                                                                      index]
                                                                  .id);

                                                      setState(() {
                                                        myBookingList[index]
                                                            .deleted = true;

                                                        myBookingList =
                                                            bookingController
                                                                .getMyBookingList(
                                                                    hideDeleted,
                                                                    hideArchived);

                                                        Get.back();
                                                        Get.snackbar(
                                                            "Booking deleted",
                                                            "Your booking has been deleted correctly",
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
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
                                    opacity: myBookingList[index].deleted ||
                                            (myBookingList[index].confirmed &&
                                                myBookingList[index].has_review)
                                        ? 0.6
                                        : 1,
                                    child: Container(
                                      padding: EdgeInsets.all(defaultPadding),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: myBookingList[index]
                                                    .confirmed
                                                ? Colors.green.withOpacity(0.5)
                                                : myBookingList[index].deleted
                                                    ? Colors.red
                                                        .withOpacity(0.5)
                                                    : Colors.grey
                                                        .withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        color: Get.isDarkMode
                                            ? Color.fromARGB(255, 34, 32, 32)
                                            : Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                defaultPadding / 2)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildAppointmentInfo(
                                                    "Date",
                                                    formatter.format(
                                                        myBookingList[index]
                                                            .date)),
                                              ),
                                              Expanded(
                                                child: buildAppointmentInfo(
                                                    "Time slot",
                                                    "${myBookingList[index].start_time} - ${myBookingList[index].end_time}"),
                                              ),
                                              Expanded(
                                                child: buildAppointmentInfo(
                                                    "Teacher",
                                                    myBookingList[index]
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
                                                  badgeColor:
                                                      (myBookingList[index]
                                                              .course_color
                                                              .toColor())
                                                          .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  badgeContent: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Text(
                                                          myBookingList[index]
                                                              .course_title,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                      myBookingList[index]
                                                              .deleted
                                                          ? Icons.delete
                                                          : myBookingList[index]
                                                                  .has_review
                                                              ? Icons.star
                                                              : !myBookingList[
                                                                          index]
                                                                      .confirmed
                                                                  ? Icons
                                                                      .watch_later_outlined
                                                                  : Icons
                                                                      .star_outline_outlined,
                                                      color: myBookingList[
                                                                  index]
                                                              .has_review
                                                          ? Color.fromARGB(
                                                              255, 239, 168, 74)
                                                          : myBookingList[index]
                                                                  .deleted
                                                              ? Colors.red
                                                              : Colors.black,
                                                    ),
                                                    Text(myBookingList[index]
                                                            .deleted
                                                        ? "Deleted"
                                                        : myBookingList[index]
                                                                .has_review
                                                            ? "Reviewed"
                                                            : !myBookingList[
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
