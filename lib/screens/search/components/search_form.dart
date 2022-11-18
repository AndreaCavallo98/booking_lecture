import 'package:booking_lecture/controller/course_controller.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/main.dart';
import 'package:booking_lecture/models/Course.dart';
import 'package:booking_lecture/models/Teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  CourseController courseController = Get.find();
  TeacherController teacherController = Get.find();
  double _correntSliderValue = 0;
  int _currentCourseId = -1;
  String _selectedDate = "";
  var formatter = new DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    courseController.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => courseController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : DropdownButtonFormField(
                    icon: const Icon(
                      Icons.menu_book,
                      color: primaryColor,
                    ),
                    items: courseController
                        .getCourseDropdownItem()
                        .map<DropdownMenuItem<int>>((Course courseItem) {
                      return DropdownMenuItem(
                        value: courseItem.id,
                        child: Row(children: [
                          Icon(
                            courseItem.id != -1
                                ? Icons.circle
                                : Icons.circle_outlined,
                            color: courseItem.color!.toColor(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: defaultPadding),
                            child: Text(courseItem.title!),
                          )
                        ]),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentCourseId = value ?? -1;
                      });
                    },
                    //validator: RequiredValidator(errorText: requiredField),
                    decoration: dropdownInputDecoration.copyWith(
                      hintText: "Select course",
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: MaterialButton(
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                ).then((value) {
                  setState(() {
                    _selectedDate =
                        value == null ? "" : formatter.format(value);
                  });
                });
              },
              color: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                  horizontal: 12, vertical: defaultPadding * 1.25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: primaryColor,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              "Select your hourly rate range",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(3)),
            ),
            child: Slider(
              value: _correntSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              thumbColor: primaryColor,
              activeColor: primaryColor,
              label: _correntSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _correntSliderValue = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                teacherController.filterCourseId = _currentCourseId;
                teacherController.filterDate = _selectedDate;
                teacherController.filterMaxHourlyRate =
                    _correntSliderValue == 0 ? -1 : _correntSliderValue.round();
                teacherController.getTeacher("all");
              },
              child: Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}

var currencies = [
  "Food",
  "Transport",
  "Personal",
  "Shopping",
  "Medical",
  "Rent",
  "Movie",
  "Salary"
];