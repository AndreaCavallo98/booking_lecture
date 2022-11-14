import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/screens/home/components/top_five_teacher.dart';
import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import 'components/courses.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(
                text: "Find Your",
                title: "Teacher",
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(defaultPadding)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Looking For Your Desire Specialist Teacher?",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: defaultPadding / 2),
                                width: 2,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFF83D047),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(defaultPadding)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Book your lecture!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Select an avaliable doctor \n book a private lecture",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Courses(),
              TopFiveTeacher(),
            ],
          ),
        ),
      ),
    );
  }
}
