import 'package:badges/badges.dart';
import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:booking_lecture/screens/booking/booking_screen.dart';
import 'package:booking_lecture/screens/details/components/reviews.dart';
import 'package:flutter/material.dart';

import '../../components/heightlight.dart';
import '../../components/rating.dart';

class TeacherDetailsScreen extends StatelessWidget {
  TeacherDetailsScreen({Key? key, required this.selectedTeacher})
      : super(key: key);

  Teacher selectedTeacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedTeacher.name} ${selectedTeacher.surname}"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/Serena_Gome.png"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(),
                    ),
                  ),
                  child: Text(
                      "BOOK A LECTURE WITH ${selectedTeacher.name!.toUpperCase()} NOW!"),
                ),
              ),
              Row(
                children: List.generate(
                    selectedTeacher.teached_courses!.length,
                    ((index) => Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Badge(
                            toAnimate: false,
                            shape: BadgeShape.square,
                            badgeColor: selectedTeacher
                                .teached_courses![index].color!
                                .toColor(),
                            borderRadius: BorderRadius.circular(8),
                            badgeContent: Text(
                                selectedTeacher.teached_courses![index].title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ),
                        ))),
              ),
              SizedBox(height: defaultPadding),
              Text(
                "About ${selectedTeacher.name}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Text(
                  selectedTeacher.description!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 4),
                          child: Rating(
                              score: selectedTeacher.reviews_average!.round()),
                        ),
                        Text(
                          "${selectedTeacher.num_reviews} reviews",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    Highlight(
                      name: "Experience",
                      text: "${selectedTeacher.num_lectures_given} Lecture",
                    ),
                    Highlight(
                      name: "Hourly rate",
                      text: "${selectedTeacher.hourly_rate} €/h",
                    ),
                  ],
                ),
              ),
              Reviews(idTeacher: selectedTeacher.id!)
            ],
          ),
        ),
      ),
    );
  }
}
