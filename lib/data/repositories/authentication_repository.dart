import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/onboarding/onboarding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///variables
  final devicesStorage = GetStorage();
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    //   screenRedirect();
    // }

    //funtion to show relevant screen
    // screenRedirect() async {
    //   devicesStorage.writeIfNull('IsFirstTime', true);
    //   devicesStorage.read('IsFirstTime') != true
    //       ? Get.offAll(() => const LoginScreen())
    //       : Get.offAll(const OnBoardingScreen());
  }
}
