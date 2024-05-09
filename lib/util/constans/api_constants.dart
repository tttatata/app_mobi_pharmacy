/* -- LIST OF Constants used in APIs -- */

// địa chỉ ip theo máy98
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String url = 'http://192.168.1.14:8000';
// Example
const String tSecretAPIKey = "cwt_live_b2da6ds3df3e785v8ddc59198f7615ba";
const stripePublishableKey =
    "pk_test_51P8SPHBfBX9Ejqptte2IEaPocCZnaJnxgbl4HPD1JFue7JOoCxwho2LVPhXBCh5Vhkyc7WthnezVWi8G4ROU4b3I00eAsvYshb";

class Constaint {
  static String clientId =
      "AdyWwYhIBpVEXxPnfHj31osJ3uAuag8ZjLJ1DoqPIBA-CSiD91hpErkUXxxYFLYuIYeKcmqpxYTyqKqu";

  static String secretKey =
      "EH3vo4MivtwR1h1hJYm7QVYQgM-J_4U_AflsHYIuCWWTbSZfXxSF_EY-5GR1OuGXXCCQ0HXknmercyCU";
  static String returnURL = "success.snippetcoder.com";
  static String cancelURL = "cancel.snippetcoder.com";
}

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
