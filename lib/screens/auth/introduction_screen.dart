import 'package:booking_lecture/constants.dart';
import 'package:booking_lecture/screens/auth/sign_in_screen.dart';
import 'package:booking_lecture/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
        title: "Welcome!",
        body:
            "Welcome and thank you to download the booking lecture app. With this mobile app you will be able to learn and improve your knowledge. No more bad grades at school and the mum will be happy",
        image: Lottie.network(
            "https://assets3.lottiefiles.com/packages/lf20_1H7IW0.json"),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: primaryColor))),
    PageViewModel(
        title: "Select subject & Teacher",
        body:
            "Choose the subject you want to learn and we will suggest experienced teachers who are right for you. Select the teacher according to your needs ",
        image: Lottie.network(
            "https://assets8.lottiefiles.com/packages/lf20_h9rxcjpi.json"),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: primaryColor))),
    PageViewModel(
        title: "What are you waiting for?",
        body:
            "Register or log in and book a lecture now and improve your knowledge with booking lecture app!",
        image: Lottie.network(
            "https://assets6.lottiefiles.com/packages/lf20_ilp95ggh.json"),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: primaryColor))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "BOOKING LECTURE APP",
            style: TextStyle(color: primaryColor),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: IntroductionScreen(
            pages: pages,
            dotsDecorator: const DotsDecorator(
                size: Size(15, 15),
                color: textColor,
                activeSize: Size.square(20),
                activeColor: primaryColor),
            showNextButton: true,
            done: const Text(
              "Done",
              style: TextStyle(fontSize: 20),
            ),
            onDone: () async {
              final _box = GetStorage();
              await _box.write("ON_BOARDING", false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            showSkipButton: true,
            skip: const Text(
              "Skip",
              style: TextStyle(fontSize: 20),
            ),
            skipColor: textColor,
            nextColor: textColor,
            doneColor: primaryColor,
            next: const Icon(
              Icons.arrow_forward,
              size: 25,
            ),
          ),
        ));
  }
}
