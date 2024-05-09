import 'dart:convert';
import 'dart:io';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/signup/verify_email.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController {
  String imageUrls = '';
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required File? images,
      required String password}) async {
    try {
      final cloudinary = CloudinaryPublic('cloudythuong', 'Upload');

      CloudinaryResponse resa = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(images!.path, folder: 'avatars'),
      );
      imageUrls = resa.secureUrl;

      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          phoneNumber: 0,
          addresses: [],
          role: '',
          token: '',
          avatar: null,
          cart: [],
          wishList: []);

      http.Response res = await http.post(
        Uri.parse('$url/api/v2/user/create-user'),
        // body: user.toJson(),
        body: jsonEncode(<String, String>{
          'id': '',
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'phoneNumber': '',
          'addrees': '',
          'avatar': imageUrls,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Get.to(() => VerifyEmailScreen(
            email: email,
          ));
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
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
