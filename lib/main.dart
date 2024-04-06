import 'package:app_mobi_pharmacy/app.dart';
import 'package:app_mobi_pharmacy/data/repositories/authentication_repository.dart';
import 'package:app_mobi_pharmacy/features/authentication/controllers/signup/signup_controller2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  //
  // Get.put(SignupController2(context: Get.context));
  runApp(const App());
}
