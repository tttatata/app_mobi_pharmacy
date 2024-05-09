import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/order.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  // Future<List<Order>> fetchCategoryProducts({
  //   required BuildContext context,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   List<Order> orderList = [];
  //   try {
  //     http.Response res = await http
  //         .get(Uri.parse('$url/api/v2/auth/get-all-orders'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body)['orders'].length; i++) {
  //           orderList.add(
  //             Order.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)['orders'][i],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   return orderList;
  // }
  Future<List<Order>> fetchCategoryProducts({
    required BuildContext context,
    String? filterStatus, // Thêm tham số này để lọc theo trạng thái đơn hàng
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Order> filteredOrderList =
        []; // Đổi tên biến để phản ánh rằng nó đã được lọc
    try {
      http.Response res = await http.get(
        Uri.parse('$url/api/v2/auth/get-all-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var orders = jsonDecode(res.body)['orders'];
          for (var orderJson in orders) {
            Order order = Order.fromJson(jsonEncode(orderJson));
            // Nếu filterStatus là null hoặc bằng 'đơn đã đặt', thì thêm tất cả đơn hàng vào danh sách
            if (filterStatus == null || filterStatus == 'Đơn đã đặt') {
              filteredOrderList.add(order);
            } else if (order.status == filterStatus) {
              // Nếu không, chỉ thêm đơn hàng có trạng thái khớp với filterStatus
              filteredOrderList.add(order);
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return filteredOrderList; // Trả về danh sách đã được lọc
  }

  Future<bool> updateOrder({
    required BuildContext context,
    required String orderId,
    required String updateData,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
          child: CircularProgressIndicator(
        strokeWidth: 2, // Độ dày của đường viền
        valueColor:
            AlwaysStoppedAnimation<Color>(Colors.blue), // Màu của hình tròn
      )), // Hiển thị circular progress indicator
    );
    await Future.delayed(Duration(seconds: 2));
    try {
      http.Response res = await http.patch(
        Uri.parse('$url/api/v2/auth/update-order/${orderId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'status': updateData}),
      );

      Navigator.of(context)
          .pop(); // Ẩn circular progress indicator khi hoàn thành

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrdersScreen()),
            );
          });
          showSnackBar(context, 'Đơn hàng đã được cập nhật thành công.');
        },
      );
      return res.statusCode == 200;
    } catch (e) {
      Navigator.of(context).pop(); // Ẩn circular progress indicator nếu có lỗi
      showSnackBar(context, e.toString());
      return false;
    }
  }
}
