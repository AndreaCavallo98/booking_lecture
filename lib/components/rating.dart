import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.score,
  }) : super(key: key);
  final int score;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(right: defaultPadding / 4),
          child: index < score
              ? SvgPicture.asset("assets/icons/star.svg")
              : SvgPicture.asset("assets/icons/voidstar.svg"),
        ),
      ),
    );
  }
}
