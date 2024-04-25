import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';

import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/helpers/network_manager.dart';
import 'package:app_mobi_pharmacy/util/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController2 extends GetxController {
  static SignupController2 get instance => Get.find();

  SignupController2({required this.context});
  //Variable00
  // final BuildContext context;
  final BuildContext context;
  final hidepassword = true.obs;
  final privatePolicy = true.obs;
  final email = TextEditingController();
  final userName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  ////SÌGNUpTEx
  void signup() async {
    try {
      /// start loading
      TFullScreenLoader.openLoadingDialog(
          "We are processing your ìnormation", TImages.acerlogo);
//check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // TFullScreenLoader.stopLoading();
        return;
      }

      ///form validation
      if (!signupFormKey.currentState!.validate()) {
        // TFullScreenLoader.stopLoading();
        return;
      }
      //privacyPolicy check
      if (!privatePolicy.value) {
        TLoaders.warningSnackbar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account , you must have to read and accept the privacy policy & term of use.');
        return;
      }
      // User user = User(
      //     id: '',
      //     name: '',
      //     email: '',
      //     password: '',
      //     phoneNumber: 0,
      //     addresses: [],
      //     role: '',
      //     token: '',
      //     avatar: '',
      //     cart: []);
      // final UserCredential = await AuthenticationRepository.instance
      //     .registerWithEmailAndPassword(
      //         email.text.trim(), password.text.trim());
      // http.Response res = await http.post(
      //   Uri.parse('$url/api/v2/user/create-user'),
      // body: jsonEncode(<String, String>{
      //   'id': '',
      //   'name': user.name,
      //   'email': user.email,
      //   'password': user.password,
      //   'phoneNumber': '',
      //   'addrees': user.name,
      //   'role': '',
      //   'avatar': '',
      // }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     showSnackBar(
      //       context,
      //       'Account created! Login with the same credentials!',
      //     );
      // Get.to(() => const VerifyEmailScreen());
      //   },
      // );
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     showSnackBar(
      //       context,
      //       'Account created! Login with the same credentials!',
      //     );
      //   },
      // );
      // // User user = User(
      // //   id: '',
      // //   name: userName.text.trim(),
      // //   password: password.text.trim(),
      // //   email: email.text.trim(),
      // //   phone: phoneNumber.text.trim(),
      // //   address: '',
      // //   type: '',
      // //   token: '',
      // // );
      // // http.Response res = await http.post(
      // //   Uri.parse('$uri/api/v2/user/create-user'),
      // //   body: user.toJson(),
      // //   headers: <String, String>{
      // //     'Content-Type': 'application/json; charset=UTF-8',
      // //   },
      // // );

      // TLoaders.succesSnackbar(title: 'create a new ');
      // // Get.to(() => const VerifyEmailScreen());
      // //register user in ther firebase authentication & save user dât in the firebase
      // // final user = await AuthenticationRepository.instance
      // //     .registerWithEmailAndPassword(
      // //         email.text.trim(), password.text.trim());
    } catch (e) {
      /// show more generic erroer to the user
      ///
      TLoaders.errorSnackbar(title: 'Oh snap!', message: e.toString());
    } finally {
      //remove loader
      TFullScreenLoader.stopLoading();
    }
  }
}
// class SignUpService {
//   // sign up user
//   void signUpUser({
//     required BuildContext context,
//     required String email,
//     required String phone,
//     required String password,
//     required String name,
//     required bool hidepassword,
//     required bool privatePolicy,
//   }) async {
//     try {
//       UserModel user = UserModel(
//         id: '',
//         name: name,
//         email: email,
//         password: password,
//         phoneNumber: '',
//         address: [''],
//         role: '',
//         avatar: '',
//       );

//       http.Response res = await http.post(
//         Uri.parse('$url/api/v2/user/create-user'),
//         body: user.toJson(),
//         // headers: <String, String>{
//         //   'Content-Type': 'application/json; charset=UTF-8',
//         // },
//       );

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           showSnackBar(
//             context,
//             'Account created! Login with the same credentials!',
//           );
//           // TLoaders.succesSnackbar(title: 'create a new ');
//           // Get.to(() => const VerifyEmailScreen());
// //       // //register user in ther firebase authentication & save use
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }
