import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();

      break;
    case 201:
      onSuccess();

      break;
    case 400:
      TLoaders.warningSnackbar(title: jsonDecode(response.body)['message']);

      break;
    case 500:
      TLoaders.errorSnackbar(title: jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
