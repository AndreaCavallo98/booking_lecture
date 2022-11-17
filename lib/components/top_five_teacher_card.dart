import 'package:badges/badges.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:booking_lecture/screens/details/teacher_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';

import '../constants.dart';
import 'rating.dart';

class TopFiveTeacherCard extends StatelessWidget {
  const TopFiveTeacherCard({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherDetailsScreen(
                  selectedTeacher: teacher,
                ),
              ));
        },
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${teacher.name!}  ${teacher.surname!}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: List.generate(
                        teacher.teached_courses!.length,
                        ((index) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Badge(
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: teacher
                                    .teached_courses![index].color!
                                    .toColor(),
                                borderRadius: BorderRadius.circular(8),
                                badgeContent:
                                    Text(teacher.teached_courses![index].title!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                        )),
                              ),
                            ))),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  Text(
                    "Experience",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    "${teacher.num_lectures_given} lectures given",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: defaultPadding / 2),
                  Text(
                    "Hourly Rate",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    "${teacher.hourly_rate}€ / hour",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding / 2),
                    child: Rating(score: teacher.reviews_average!.round()),
                  ),
                  Image.asset(
                    //teacher.image!,
                    "assets/images/Serena_Gome.png",
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
