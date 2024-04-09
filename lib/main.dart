import 'package:app_mobi_pharmacy/app.dart';
import 'package:app_mobi_pharmacy/bindings/general_bindings.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';

import 'package:app_mobi_pharmacy/data/repositories/authentication_repository.dart';
import 'package:app_mobi_pharmacy/features/authentication/controllers/login/login_controller.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/home.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/routes.dart';
import 'package:app_mobi_pharmacy/util/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

// Future<void> main() async {
//   // final WidgetsBinding widgetsBinding =
//   //     WidgetsFlutterBinding.ensureInitialized();
//   // await GetStorage.init();
//   // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
//   //     .then(
//   //   (FirebaseApp value) => Get.put(AuthenticationRepository()),
//   // );
//   //
//   // Get.put(SignupController2(context: Get.context));
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(
//       create: (context) => UserProvider(),
//     ),
//   ], child: const App()));
// }

// class App extends StatefulWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   // final LoginController _loginController = LoginController();
//   @override
//   void initState() {
//     super.initState();
//     // _loginController.getUserData(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       initialBinding: GeneralBindings(),
//       home: Provider.of<UserProvider>(context).user.token.isNotEmpty
//           ? const HomeScreen()
//           : const LoginScreen(),
//       // const Scaffold(
//       //   backgroundColor: TColors.primary,
//       //   body: Center(
//       //     child: CircularProgressIndicator(
//       //       color: Colors.white,
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LoginController authService = LoginController();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const NavigationMenu()
          : const LoginScreen(),
    );
  }
}
