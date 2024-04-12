import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/signup/signup.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/home.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/product_details.dart';
import 'package:app_mobi_pharmacy/features/shop/views/search/search_product.dart';
import 'package:app_mobi_pharmacy/features/shop/views/sub_category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// // We use name route
// // All our routes will be available here
// final Map<String, WidgetBuilder> routes = {
//   InitScreen.routeName: (context) => const InitScreen(),
//   SplashScreen.routeName: (context) => const SplashScreen(),
//   SignInScreen.routeName: (context) => const SignInScreen(),
//   ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
//   LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
//   SignUpScreen.routeName: (context) => const SignUpScreen(),
//   CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
//   CompleteSignupScreen.routeName: (context) => const CompleteSignupScreen(),
//   OtpScreen.routeName: (context) => const OtpScreen(),
//   HomeScreen.routeName: (context) => const HomeScreen(),
//   ProductsScreen.routeName: (context) => const ProductsScreen(),
//   DetailsScreen.routeName: (context) => const DetailsScreen(),
//   CartScreen.routeName: (context) => const CartScreen(),
//   ProfileScreen.routeName: (context) => const ProfileScreen(),
// };

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case SubCategoriesScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SubCategoriesScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
  }
}
