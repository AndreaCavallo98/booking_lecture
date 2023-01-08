import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/screens/home/components/top_five_teacher.dart';
import 'package:booking_lecture/screens/home/components/upcoming_lecture.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../components/custom_app_bar.dart';
import '../../components/section_title.dart';
import 'components/courses.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final keyUpcoming = GlobalKey();
  final keyCourses = GlobalKey();
  final keyTopFive = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _box = GetStorage();
      bool showCaseHomePage = await _box.read("SHOWCASE_HOMEPAGE");
      if (showCaseHomePage == null) {
        ShowCaseWidget.of(context)
            .startShowCase([keyCourses, keyUpcoming, keyTopFive]);
        _box.write("SHOWCASE_HOMEPAGE", false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Homepage",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
              UpcomingLecture(
                keyShowCase: keyUpcoming,
              ),
              Courses(
                keyShowCase: keyCourses,
              ),
              TopFiveTeacher(
                keyShowCase: keyTopFive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
