import 'package:booking_lecture/components/custom_show_case_widget.dart';
import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/controller/teacher_controller.dart';
import 'package:booking_lecture/models/Course.dart';
import 'package:booking_lecture/screens/details/teacher_details_screen.dart';
import 'package:booking_lecture/screens/teacher/components/teacher_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../components/custom_app_bar.dart';
import '../../models/Teacher.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  TeacherController teacherController = Get.find();
  final searchController = TextEditingController();
  //String searchInput = te;

  GlobalKey keyFilters = GlobalKey();
  GlobalKey keySearchbar = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _box = GetStorage();
      bool showCaseHomePage = await _box.read("SHOWCASE_TEACHERS");
      if (showCaseHomePage == null) {
        ShowCaseWidget.of(context).startShowCase([keyFilters, keySearchbar]);
        _box.write("SHOWCASE_TEACHERS", false);
      }

      searchController.text = teacherController.searchInput;
      teacherController.getTeacher("all");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                //const CustomAppBar(text: "Teachers", title: "All"),
                SliverAppBar(
                  backgroundColor: Get.isDarkMode
                      ? Color.fromARGB(255, 34, 32, 32)
                      : Colors.white,
                  //title: Text("PROVAAAAAAA"),
                  expandedHeight: 100,
                  flexibleSpace: CustomAppBar(
                    text: "Teachers",
                    title: "All",
                    keyShowCase: keyFilters,
                  ),
                ),
              ]),
          body: Column(
            children: [
              Container(
                color: Get.isDarkMode
                    ? Color.fromARGB(255, 34, 32, 32)
                    : Colors.white,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: CustomShowCaseWidget(
                    globalKey: keySearchbar,
                    description:
                        "Use this searchbar to quickly search by course or teacher's name/surname",
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search name or course...',
                          border: OutlineInputBorder(
                              //borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: primaryColor))),
                      onChanged: ((value) {
                        setState(() {
                          teacherController.searchInput = value;
                        });
                      }),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Obx(() => teacherController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : teacherController.getTeacherList().isEmpty
                          ? Container(
                              child: const Center(
                                  child: Text(
                                      "No teacher finded with your requirement, try to change filter")),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              //physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  teacherController.getTeacherList().length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (context, index) => TeacherCard(
                                teacher:
                                    teacherController.getTeacherList()[index],
                                press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TeacherDetailsScreen(
                                      selectedTeacher: teacherController
                                          .getTeacherList()[index],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
