import 'package:app_mobi_pharmacy/app.dart';
import 'package:app_mobi_pharmacy/bindings/general_bindings.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';

import 'package:app_mobi_pharmacy/features/authentication/controllers/login/login_controller.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/home.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/routes.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51P8SPHBfBX9Ejqptte2IEaPocCZnaJnxgbl4HPD1JFue7JOoCxwho2LVPhXBCh5Vhkyc7WthnezVWi8G4ROU4b3I00eAsvYshb";
  await Stripe.instance.applySettings();
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
        home:
            //  Provider.of<UserProvider>(context).user.token.isNotEmpty
            //     ?
            const NavigationMenu()
        // : const LoginScreen(),
        );
  }
}
