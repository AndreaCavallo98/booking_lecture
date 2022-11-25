import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageManager {
  static final _box = GetStorage();

  static String? getToken() {
    return _box.read("jwtToken") != null ? _box.read("jwtToken") : null;
  }
}