import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Coupon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CheckOutServices {
  void createneworder({
    required BuildContext context,
    required List<Map<String, dynamic>> cartItems,
    required double totalAmount,
    required String payment,
  }) async {
    print(totalAmount);
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
          'paymentInfo': {'type': payment},
        }),
      );
      print(jsonDecode(res.body));
      if (jsonDecode(res.body)['success'] == true)
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SuccesScreen(
                    image: TImages.successfulPaymentIcon,
                    title: 'Payment Success!',
                    subtitle: 'Your item will be shipped soon!',
                    onPressed: () => Get.offAll(() => const NavigationMenu()),
                  )),
        );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Coupon?> fetchCoupon({
    required BuildContext context,
    required String couponname,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Coupon? coupon; // Khai báo biến để lưu trữ coupon

    try {
      http.Response res = await http.get(
        Uri.parse('$url/api/v2/coupon/get-coupon-value/${couponname}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var data = jsonDecode(res.body);
          if (data['couponCode'] != null && data['couponCode'].isNotEmpty) {
            // Giả sử rằng 'couponCode' là một đối tượng và không phải là một danh sách
            coupon = Coupon.fromJson(jsonEncode(data['couponCode']));
          }
        },
      );
      print(coupon);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return coupon; // Trả về coupon hoặc ném lỗi nếu không tìm thấy
  }
}
