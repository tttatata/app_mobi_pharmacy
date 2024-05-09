import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/order.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();

  Future<List<Product>> fetchUnReviewedProducts({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> unreviewedProducts = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$url/api/user/unreviewed-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Giả định rằng API trả về một mảng các sản phẩm chưa được đánh giá
          var productsJson = jsonDecode(res.body);
          for (var productJson in productsJson) {
            Product product = Product.fromJson(jsonEncode(productJson));
            unreviewedProducts.add(product);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return unreviewedProducts; // Trả về danh sách sản phẩm chưa được đánh giá
  }
}
