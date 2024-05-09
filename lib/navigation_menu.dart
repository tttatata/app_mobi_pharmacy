import 'package:app_mobi_pharmacy/chatSreen.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/settings/settings.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/home.dart';
import 'package:app_mobi_pharmacy/features/shop/views/category/category.dart';
import 'package:app_mobi_pharmacy/features/shop/views/wishlist/wishlist.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  static const String routeName = "/actual-home";
  const NavigationMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.category),
              label: 'Category',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
            // Thêm icon chat vào navigation bar
            NavigationDestination(
              icon: Icon(Iconsax.message),
              label: 'Chat',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
    const ChatScreen(), // Thêm ChatScreen vào danh sách màn hình
  ];
}
