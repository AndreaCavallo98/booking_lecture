// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/controller/auth_controller.dart';
import 'package:booking_lecture/controller/booking_controller.dart';
import 'package:booking_lecture/controller/calendar_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../controller/nav_bar_controller.dart';
import '../../models/Course.dart';
import '../../models/Teacher.dart';
import '../dashboard/dashboard_screen.dart';
import 'components/calendar.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key, required this.teacher}) : super(key: key);

  Teacher teacher;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var formatter = new DateFormat('dd/MM/yyyy');
  CalendarController calendarController = Get.put(CalendarController());
  BookingController bookingController = Get.find();
  AuthController authController = Get.find();
  NavBarController navBarController = Get.find();
  NotificationServices notificationServices = Get.find();
  int selectedSloats = -1;
  int? selectedCourse;

  @override
  void initState() {
    super.initState();
    selectedCourse = widget.teacher.teached_courses![0].id!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calendarController.changeSelectedDate(widget.teacher.id!, DateTime.now());
    });
  }

  int secondsBetween(DateTime from, DateTime to) {
    return (to.difference(from).inSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking lecture"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              "What you want to learn with ${widget.teacher.name}?",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: DropdownButtonFormField(
              value: widget.teacher.teached_courses?[0].id,
              icon: const Icon(
                Icons.menu_book,
                color: primaryColor,
              ),
              items: widget.teacher.teached_courses
                  ?.map<DropdownMenuItem<int>>((Course courseItem) {
                return DropdownMenuItem(
                  //senabled: courseItem.id == _currentCourseId,
                  value: courseItem.id,
                  child: Row(children: [
                    Icon(
                      courseItem.id != -1
                          ? Icons.circle
                          : Icons.circle_outlined,
                      color: courseItem.color!.toColor(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Text(courseItem.title!),
                    )
                  ]),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCourse = value!;
                });
              },
              //validator: RequiredValidator(errorText: requiredField),
              decoration: dropdownInputDecoration.copyWith(
                hintText: "Select course",
                fillColor: Get.isDarkMode
                    ? Color.fromARGB(255, 34, 32, 32)
                    : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: defaultPadding,
                left: defaultPadding,
                right: defaultPadding),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              "When you want book the lecture?",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding),
            child: Calendar(
              teacherId: widget.teacher.id!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Slots",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Obx(() => calendarController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: calendarController.dailyBookingSoltList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.77,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSloats = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: calendarController
                                  .dailyBookingSoltList[index].avaliable
                              ? selectedSloats == index
                                  ? primaryColor
                                  : Get.isDarkMode
                                      ? Color.fromARGB(255, 34, 32, 32)
                                      : Colors.white
                              : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Text(
                          "${calendarController.dailyBookingSoltList[index].from.toString()} - ${calendarController.dailyBookingSoltList[index].to.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: calendarController
                                          .dailyBookingSoltList[index].avaliable
                                      ? Get.isDarkMode
                                          ? Colors.white
                                          : textColor
                                      : Colors.white),
                        ),
                      ),
                    ),
                  ),
                )),
          Padding(
            padding: const EdgeInsets.only(
                top: defaultPadding,
                left: defaultPadding,
                right: defaultPadding),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Obx(() => calendarController.isLoading.value || selectedSloats == -1
              ? Container()
              : !calendarController
                      .dailyBookingSoltList[selectedSloats].avaliable
                  ? Center(
                      child:
                          Text("Teacher isn't avaliable anymore in this slot"))
                  : Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "",
                              titleStyle: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              content: Column(
                                children: [
                                  Container(
                                    height: 160,
                                    width: 150,
                                    child: Lottie.network(
                                        fit: BoxFit.fill,
                                        'https://assets2.lottiefiles.com/packages/lf20_zwkm4xbs.json'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Text(
                                      "THE LECTURE WILL BE REGISTERED!",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Text(
                                      "Will you book a lecture with Teacher ${widget.teacher.name} " +
                                          "in date ${formatter.format(calendarController.selectedDateTime.value)} " +
                                          "time slot:  ${calendarController.dailyBookingSoltList[selectedSloats].from} - "
                                              "${calendarController.dailyBookingSoltList[selectedSloats].to} ",
                                    ),
                                  ),
                                ],
                              ),
                              textCancel: "NO",
                              textConfirm: "YES",
                              barrierDismissible: false,
                              confirmTextColor: Colors.white,
                              cancelTextColor: textColor,
                              buttonColor: Colors.green,
                              onConfirm: () async {
                                int newBookingId =
                                    await bookingController.addBooking(
                                  selectedCourse!,
                                  widget.teacher.id!,
                                  authController.authId,
                                  formatter.format(calendarController
                                      .selectedDateTime.value),
                                  15 + selectedSloats,
                                  15 + selectedSloats + 1,
                                );

                                navBarController.selectedIndex.value = 2;

                                // Calculating seconds beetween today & half of haur before meeting starting
                                DateTime bookingDate = calendarController
                                    .selectedDateTime.value
                                    .add(Duration(hours: 15 + selectedSloats));

                                DateTime halfHourBeforeLecture =
                                    bookingDate.subtract(Duration(minutes: 30));

                                int showNotificationAfterSeconds =
                                    secondsBetween(
                                        DateTime.now(), halfHourBeforeLecture);

                                notificationServices.showScheduleNotification(
                                    id: newBookingId,
                                    title: "Today lesson is about to begin!",
                                    body:
                                        "we remind you that there is less than half an hour until your lesson with the teacher ${widget.teacher.name} begins. Details -> DATE: ${formatter.format(calendarController.selectedDateTime.value)} SLOT TIME: ${calendarController.dailyBookingSoltList[selectedSloats].from} - ${calendarController.dailyBookingSoltList[selectedSloats].to}. We wish you good learning!",
                                    seconds: showNotificationAfterSeconds);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DashBoard()),
                                    (Route route) => false);
                              });
                        },
                        child: Text("Confirm  Booking"),
                      ),
                    )),
        ],
      ),
    );
  }
}
