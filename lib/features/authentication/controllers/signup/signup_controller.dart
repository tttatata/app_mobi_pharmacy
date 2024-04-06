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
import 'package:image_picker/image_picker.dart';

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

      UserModel user = UserModel(
          id: '',
          name: name,
          email: email,
          password: password,
          phoneNumber: '',
          address: [],
          role: '',
          avatar: imageUrls);
      http.Response res = await http.post(
        Uri.parse('$url/api/v2/user/create-user'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Get.to(() => VerifyEmailScreen(
            email: email,
          ));
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
