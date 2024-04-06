import 'package:app_mobi_pharmacy/features/authentication/controllers/login/login_controller.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/password_configuration/forget_password.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/signup/signup.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

enum Signin {
  signin,
}

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<TLoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final hidepassword = true.obs;

  final List<String?> errors = [];
  final LoginController _loginController = LoginController();

  // @override
  // void dispose() {
  //   super.dispose();

  //   _passwordController.dispose();

  //   _emailController.dispose();
  // }

  void signInUser() {
    _loginController.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            //email

            TextFormField(
              controller: _emailController,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            //password
            Obx(
              () => TextFormField(
                controller: _passwordController,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: hidepassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => hidepassword.value = !hidepassword.value,
                    icon: Icon(
                        hidepassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            ///remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe)
                  ],
                ),

                ///Forget Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            //sign in botton
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      signInUser();
                      // if all are valid then go to success screen
                    },
                    child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
