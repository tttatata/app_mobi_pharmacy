import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CheckOutServices {
  void createneworder({
    required BuildContext context,
    required List<Map<String, dynamic>> cartItems,
    required int totalAmount,
    required String paynment,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // final addressselect = Provider.of<UserProvider>(context).selectedAddress;
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$url/api/v2/auth/create-order'), // Điều chỉnh đường dẫn API tại đây
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider
              .user.token, // Giả sử token được lưu trong userProvider
        },

        body: jsonEncode({
          'cart': cartItems,
          'shippingAddress': userProvider.selectedAddress,
          'totalPrice': totalAmount,
          'paymentInfo': {'type': paynment},
        }),
      );
      print(jsonDecode(res.body));
      if (jsonDecode(res.body)['success'] == true)
        TLoaders.succesSnackbar(
          title: 'Đặt hàng thành công',
          message: 'Đơn hàng của bạn đã được lên đơn và chờ phê duyệt.',
        );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
