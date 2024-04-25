/* -- LIST OF Constants used in APIs -- */

// địa chỉ ip theo máy98
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String url = 'http://192.168.1.17:8000';
// Example
const String tSecretAPIKey = "cwt_live_b2da6ds3df3e785v8ddc59198f7615ba";
const stripePublishableKey =
    "pk_test_51P8SPHBfBX9Ejqptte2IEaPocCZnaJnxgbl4HPD1JFue7JOoCxwho2LVPhXBCh5Vhkyc7WthnezVWi8G4ROU4b3I00eAsvYshb";
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
