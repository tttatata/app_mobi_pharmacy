// import 'dart:convert';

// import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void httpErrorHandle({
//   required http.Response response,
//   required BuildContext context,
//   required VoidCallback onSuccess,
// }) {
//   switch (response.statusCode) {
//     case 200:
//       onSuccess();
//       break;
//     case 400:
//       TLoaders.errorSnackbar(context,
//           message: jsonDecode(response.body)['msg']);
//       break;
//     case 500:
//       TLoaders.errorSnackbar(context,
//           message: jsonDecode(response.body)['error']);
//       break;
//     default:
//       TLoaders.errorSnackbar(context, message: response.body);
//   }
// }
import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
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
    case 400:
      showSnackBar(
        context,
        jsonDecode(response.body)['message'],
      );
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
