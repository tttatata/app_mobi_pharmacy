import 'package:app_mobi_pharmacy/common/widgets/login_signup/form_divider.dart';
import 'package:app_mobi_pharmacy/common/widgets/login_signup/social_buttons.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/signup/widgets/sigup_form.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                //form
                const TSignupForm(),

                ///divider
                TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
                const SizedBox(height: TSizes.spaceBtwSections),
                //social button
                const TSocialButtons(),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ));
  }
}
