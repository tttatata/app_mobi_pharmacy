import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/address.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/profile.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:app_mobi_pharmacy/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TBillingUserSection extends StatefulWidget {
  const TBillingUserSection({super.key});

  @override
  _TBillingUserSectionState createState() => _TBillingUserSectionState();
}

class _TBillingUserSectionState extends State<TBillingUserSection> {
  final _formKey = GlobalKey<FormState>();

  final hidepassword = true.obs;
  final privatePolicy = true.obs;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool remember = false;
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final user = context.watch<UserProvider>().user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSetionHeading(
            title: 'Thông tin khách hàng',
            buttonTitle: 'Change',
            onPressed: () => Get.to(() => const ProfileScreen())),
        //  => _handleChangeButtonPressed(context)

        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Column(
          children: [
            Row(
              children: [
                Text('Tên khách hàng',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  user.name, // Sử dụng toán tử null-aware
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Row(
              children: [
                Text('Số điện thoại',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  user.phoneNumber.toInt() != 0
                      ? user.phoneNumber.toString()
                      : 'Trống', // Sử dụng toán tử null-aware
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Row(
              children: [
                Text('email', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  user.email, // Sử dụng toán tử null-aware
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
