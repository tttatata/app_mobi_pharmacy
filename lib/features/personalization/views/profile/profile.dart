import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/widgets/profile_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    String message = user.phoneNumber == 0
        ? 'Bạn chưa nhập số điện thoại'
        : user.phoneNumber.toString();
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                      image: TImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              //details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSetionHeading(
                title: 'Profile information',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProfileMenu(
                title: 'Name',
                value: user.name,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Username',
                value: user.name.toUpperCase(),
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              //heading
              const TSetionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              ProfileMenu(
                icon: Iconsax.copy,
                title: 'User ID',
                value: user.id,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Email',
                value: user.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: user.phoneNumber == 0
                    ? 'Bạn chưa nhập số điện thoại'
                    : user.phoneNumber.toString(),
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'Male',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Date of birth',
                value: '12/10/2001',
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
