import 'dart:ffi';

import 'package:flutter/foundation.dart';

class BookingSlot {
  late int from;
  late int to;
  late bool avaliable;

  BookingSlot({
    required this.from,
    required this.to,
    required this.avaliable,
  });

  BookingSlot.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    avaliable = json['avaliable'];
  }
}
