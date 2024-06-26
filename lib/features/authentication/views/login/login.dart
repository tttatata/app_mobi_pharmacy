import 'package:app_mobi_pharmacy/common/styles/spacing_styles.dart';
import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/login_signup/form_divider.dart';
import 'package:app_mobi_pharmacy/common/widgets/login_signup/social_buttons.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/widgets/login_form.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/widgets/login_header.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = "/s";

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Login',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                ///logo , title subtitle
                const TLoginHeader(),
                const TLoginForm(),
                //Vivider
                TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
                const SizedBox(height: TSizes.spaceBtwSections),

                ///fotter
                const TSocialButtons()
              ],
            ),
          ),
        ));
  }
}
