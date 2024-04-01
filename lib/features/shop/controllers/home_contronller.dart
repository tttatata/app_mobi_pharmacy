import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final caroualCurrentIndex = 0.obs;
  void updatePageIndicator(index) {
    caroualCurrentIndex.value = index;
  }
}
