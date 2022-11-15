import 'package:get/get.dart';

class NavBarController extends GetxController {
  var selectedIndex = 0.obs;

  changePageIndex(int index) {
    selectedIndex.value = index;
  }
}
