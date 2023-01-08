import 'dart:ffi';

import 'package:flutter/foundation.dart';

class BookingSlot {
  late int from;
  late int to;
  late String status;

  BookingSlot({
    required this.from,
    required this.to,
    required this.status,
  });

  BookingSlot.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    status = json['status'];
  }
}
