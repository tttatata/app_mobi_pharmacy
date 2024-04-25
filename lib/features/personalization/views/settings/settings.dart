import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/list_titles/settings_menu_title.dart';
import 'package:app_mobi_pharmacy/common/widgets/list_titles/user_profile_title.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/personalization/controllers/settings_controller.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/address.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/profile.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/order.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  TUSerProfileTitle(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSetionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and complete orders',
                    onTap: () => Get.to(() => const OrdersScreen()),
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withraw balance to registered bank account',
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all the discounted coupons',
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notifications message',
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connect',
                    onTap: () {},
                  ),
                  //app setting
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSetionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSettingsMenuTitle(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud',
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                    onTap: () {},
                  ),
                  //log out
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => SettingServices().logOut(context),
                      child: const Text('Log out'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
