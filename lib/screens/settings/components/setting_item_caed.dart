import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({
    Key? key,
    this.text,
    required this.icon,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String? text;
  final Icon icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Color.fromARGB(255, 34, 32, 32) : Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        leading: icon,
        title: Text(
          text!,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing: CupertinoSwitch(
          activeColor: primaryColor,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
