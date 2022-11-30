import 'package:booking_lecture/controller/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  static final DateTime _date = DateTime.now();

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  BookingController bookingController = Get.find();

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
          child: Column(
            children: List.generate(
              bookingController.myBookingList.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultPadding / 2)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: buildAppointmentInfo("Date",
                                  "${bookingController.myBookingList[index].date}"),
                            ),
                            Expanded(
                              child: buildAppointmentInfo("Time",
                                  "${bookingController.myBookingList[index].start_time} - ${bookingController.myBookingList[index].end_time}"),
                            ),
                            Expanded(
                              child: buildAppointmentInfo(
                                  "Teacher",
                                  bookingController.myBookingList[index]
                                      .teacher_name_surname),
                            ),
                          ],
                        ),
                        Divider(height: defaultPadding * 2),
                        Row(
                          children: [
                            Expanded(
                              child: buildAppointmentInfo(
                                "Type",
                                "Dentiest",
                              ),
                            ),
                            Expanded(
                              child:
                                  buildAppointmentInfo("Place", "City Clinic"),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: redColor),
                                child: Text("Cancel"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
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
