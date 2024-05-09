import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices extends GetxController {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/v2/auth/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> addToWishList({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/v2/auth/add-to-wishlist'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      print(jsonDecode(res.body)['wishList']);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(wishList: jsonDecode(res.body)['wishList']);
          userProvider.setUserFromModel(user);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Đã thêm vào danh sách yêu thích thành công!')),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeFromWishList({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$url/api/v2/auth/remove-from-wishlist/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(wishList: jsonDecode(res.body)['wishList']);

          userProvider.setUserFromModel(user);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Đẫ xóa khỏi danh sách yêu thích thành công!')),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
