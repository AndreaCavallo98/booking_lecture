import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:showcaseview/showcaseview.dart';

import '../constants.dart';

class CustomShowCaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowCaseWidget(
      {super.key,
      required this.description,
      required this.child,
      required this.globalKey});

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      showArrow: true,
      tooltipPadding: EdgeInsets.all(defaultPadding),
      targetPadding: EdgeInsets.all(defaultPadding),
      tooltipBackgroundColor: Color(0xFFD68325),
      textColor: Colors.white,
      description: description,
      child: child,
    );
  }
}
