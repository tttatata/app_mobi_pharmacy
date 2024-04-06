/* -- LIST OF Constants used in APIs -- */

// địa chỉ ip theo máy98
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String url = 'http://192.168.10.127:8000';
// Example
const String tSecretAPIKey = "cwt_live_b2da6ds3df3e785v8ddc59198f7615ba";

Future<File?> pickImages() async {
  File? images;
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      images = File(files.files[0].path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

// Future<String?> pickImages() async {
//   String? images;
//   try {
//     var files = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );
//     if (files != null && files.files.isNotEmpty) {
//       images = files.files[0].path;
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//   return images;
// }

// Future<void> pickImages() async {}
// uploadUserProfilePicture() async {
//   final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 70,
//       maxHeight: 512,
//       maxWidth: 512);
//   if (image != null) {
//     final imageUrl = files.files[0].path;
//   }
// }
