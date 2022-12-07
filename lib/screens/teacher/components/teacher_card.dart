import 'package:badges/badges.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/rating.dart';
import '../../../constants.dart';

class TeacherCard extends StatefulWidget {
  const TeacherCard({
    Key? key,
    required this.teacher,
    required this.press,
  }) : super(key: key);

  final Teacher teacher;
  final VoidCallback press;

  @override
  State<TeacherCard> createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? Color.fromARGB(255, 34, 32, 32) : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.teacher.name}  ${widget.teacher.surname}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  Text(
                    "Experience",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "${widget.teacher.num_lectures_given} lectures",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  Text(
                    "Hourly Rate",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "${widget.teacher.hourly_rate}€/h",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                  child: Rating(score: widget.teacher.reviews_average!.round()),
                ),
                Expanded(
                  child: Image.asset(
                    //doctor.image!,
                    "assets/images/Serena_Gome.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 90,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          widget.teacher.teached_courses!.length,
                          ((index) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Badge(
                                  toAnimate: false,
                                  shape: BadgeShape.square,
                                  badgeColor: widget
                                      .teacher.teached_courses![index].color!
                                      .toColor(),
                                  borderRadius: BorderRadius.circular(8),
                                  badgeContent: Text(
                                      widget.teacher.teached_courses![index]
                                          .title!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                      )),
                                ),
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
