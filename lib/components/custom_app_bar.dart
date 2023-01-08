import 'package:booking_lecture/components/custom_show_case_widget.dart';
import 'package:booking_lecture/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  GlobalKey keyShowCase;

  CustomAppBar({
    required this.keyShowCase,
    Key? key,
    required this.text,
    required this.title,
  }) : super(key: key);

  final String text, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: "$text\n",
              style: Theme.of(context).textTheme.headline6,
              children: [
                TextSpan(
                  text: title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomShowCaseWidget(
            description: "Tap here to filter teachers on your requirements",
            globalKey: keyShowCase,
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              ),
              icon: Icon(Icons.filter_list),
            ),
          ),
          // TO DO: order by
        ],
      ),
    );
  }
}
