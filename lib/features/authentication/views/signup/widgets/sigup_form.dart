import 'dart:io';

import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/features/authentication/controllers/signup/signup_controller.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/signup/widgets/terms_conditions_checkbox.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:app_mobi_pharmacy/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

enum Signup {
  signup,
}

class TSignUpForm extends StatefulWidget {
  const TSignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<TSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final Signup _signup = Signup.signup;
  final hidepassword = true.obs;
  final privatePolicy = true.obs;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SignUpController _signUpController = SignUpController();
  File? images;
  bool remember = false;
  final List<String?> errors = [];

  void signUpUser() {
    _signUpController.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      images: images,
    );
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });

    print('images:$images');
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: _formKey,
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
                ElevatedButton(
                  onPressed: selectImages,
                  child: const Text('Change Profile Picture'),
                ),
              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Username

          TextFormField(
            controller: _nameController,
            validator: (value) =>
                TValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Email
          TextFormField(
            controller: _emailController,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // //PhoneNumber
          // TextFormField(
          //   controller: _phoneController,
          //   validator: (value) => TValidator.validatePhoneNumber(value),
          //   decoration: const InputDecoration(
          //       labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          // ),
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
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///tém&condition checkbox
          const TTermsAndConditionCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),

          ///sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signUpUser();
                  // if all are valid then go to success screen
                }
              },
              child: const Text(TTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}

// ///////
// import 'dart:io';

// import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
// import 'package:app_mobi_pharmacy/features/authentication/controllers/signup/signup_controller.dart';
// import 'package:app_mobi_pharmacy/features/authentication/controllers/signup/signup_controller2.dart';
// import 'package:app_mobi_pharmacy/features/authentication/views/signup/verify_email.dart';
// import 'package:app_mobi_pharmacy/features/authentication/views/signup/widgets/terms_conditions_checkbox.dart';
// import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
// import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
// import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
// import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
// import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
// import 'package:app_mobi_pharmacy/util/validators/validation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';

// enum Signup {
//   signup,
// }

// class TSignUpForm extends StatefulWidget {
//   const TSignUpForm({super.key});

//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<TSignUpForm> {
//   // final profileController = Get.put(SignupController2());
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     final controller = Get.put(SignupController2(context: context));
//     final dark = THelperFunctions.isDarkMode(context);
//     return Form(
//       key: controller.signupFormKey,
//       child: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Column(
//               children: [
//                 const TCircularImage(
//                   image: TImages.user,
//                   width: 80,
//                   height: 80,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Change Profile Picture'),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: TSizes.spaceBtwInputFields),
//           //Username

//           TextFormField(
//             controller: controller.userName,
//             validator: (value) =>
//                 TValidator.validateEmptyText('Username', value),
//             expands: false,
//             decoration: const InputDecoration(
//                 labelText: TTexts.username,
//                 prefixIcon: Icon(Iconsax.user_edit)),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
//           //Email
//           TextFormField(
//             controller: controller.email,
//             validator: (value) => TValidator.validateEmail(value),
//             decoration: const InputDecoration(
//                 labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
//           // //PhoneNumber
//           // TextFormField(
//           //   controller: _phoneController,
//           //   validator: (value) => TValidator.validatePhoneNumber(value),
//           //   decoration: const InputDecoration(
//           //       labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
//           // ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),

//           //password
//           Obx(
//             () => TextFormField(
//               controller: controller.password,
//               validator: (value) => TValidator.validatePassword(value),
//               obscureText: controller.hidepassword.value,
//               decoration: InputDecoration(
//                 labelText: TTexts.password,
//                 prefixIcon: const Icon(Iconsax.password_check),
//                 suffixIcon: IconButton(
//                   onPressed: () => controller.hidepassword.value =
//                       !controller.hidepassword.value,
//                   icon: Icon(controller.hidepassword.value
//                       ? Iconsax.eye_slash
//                       : Iconsax.eye),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),

//           ///tém&condition checkbox
//           const TTermsAndConditionCheckbox(),
//           const SizedBox(height: TSizes.spaceBtwSections),

//           ///sign up button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: controller.signup

//               // if (_formKey.currentState!.validate()) {
//               //   signUpUser();
//               //   // if all are valid then go to success screen
//               // }
//               ,
//               child: const Text(TTexts.createAccount),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
// /////
