import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Event.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final caroualCurrentIndex = 0.obs;
  void updatePageIndicator(index) {
    caroualCurrentIndex.value = index;
  }

  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
  }) async {
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$url/api/v2/product/get-all-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(productList);
          for (int i = 0; i < jsonDecode(res.body)['products'].length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)['products'][i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Event>> fetchSaleProducts({
    required BuildContext context,
  }) async {
    List<Event> productSaleList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$url/api/v2/event/get-all-events'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      print(jsonDecode(res.body)['events']);
      for (int i = 0; i < jsonDecode(res.body)['events'].length; i++) {
        productSaleList.add(
          Event.fromJson(
            jsonEncode(
              jsonDecode(res.body)['events'][i],
            ),
          ),
        );
      }
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     for (int i = 0; i < jsonDecode(res.body)['events'].length; i++) {
      //       productSaleList.add(
      //         Product.fromJson(
      //           jsonEncode(
      //             jsonDecode(res.body)['events'][i],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productSaleList;
  }
//   Future<List<dynamic>> fetchSaleProducts({
//   required BuildContext context,
// }) async {
//   List<dynamic> productSaleList = [];
//   try {
//     http.Response res = await http.get(
//       Uri.parse('$url/api/v2/event/get-all-events'),
//       headers: {'Content-Type': 'application/json; charset=UTF-8'},
//     );
//     print(jsonDecode(res.body)['events']);
//     for (int i = 0; i < jsonDecode(res.body)['events'].length; i++) {
//       productSaleList.add(
//         Product.fromJson(
//           jsonEncode(
//             jsonDecode(res.body)['events'][i],
//           ),
//         ),
//       );
//     }
//   } catch (e) {
//     // Xử lý lỗi nếu cần
//   }
//   return productSaleList;
// }
}
