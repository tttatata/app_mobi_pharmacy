import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileServices {
  void updateProfile({
    required BuildContext context,
    required String addressId, // Thêm id của địa chỉ cần cập nhật
    required Map<String, dynamic> addressData,
    required VoidCallback onSuccessfulUpdate,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$url/api/v2/auth/update-address'), // Điều chỉnh endpoint cho phù hợp
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider
              .user.token, // Giả sử token được lưu trong userProvider
        },
        body: json.encode({
          'addressId': addressId, // Gửi id của địa chỉ cần cập nhật
          ...addressData, // Sử dụng spread operator để thêm dữ liệu địa chỉ
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Cập nhật thông tin người dùng sau khi cập nhật địa chỉ thành công
          User user = userProvider.user.copyWith(
            addresses: jsonDecode(res.body)['addresses'],
          );
          userProvider.setUserFromModel(user);
          TLoaders.succesSnackbar(
            title: 'Cập nhật địa chỉ thành công',
            message: 'Địa chỉ của bạn đã được cập nhật.',
          );
          onSuccessfulUpdate();
        },
      );
    } catch (e) {
      // Xử lý lỗi từ phía client
      showSnackBar(context, e.toString());
    }
  }
}
