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

class AddressServices {
  void addAddress({
    required BuildContext context,
    required Map<String, dynamic> addressData,
    required VoidCallback onSuccessfulUpdate,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(addressData);
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/v2/auth/add-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider
              .user.token, // Giả sử token được lưu trong userProvider
        },
        body: json.encode(addressData),
      );
      print(jsonDecode(res.body)['addresses']);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Cập nhật thông tin người dùng sau khi cập nhật địa chỉ thành công
          User user = userProvider.user
              .copyWith(addresses: jsonDecode(res.body)['addresses']);
          userProvider.setUserFromModel(user);
          TLoaders.succesSnackbar(
            title: 'Thêm địa chỉ thành công',
            message: 'Địa chỉ mới đã được thêm vào hồ sơ của bạn.',
          );
          onSuccessfulUpdate();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateAddress({
    required BuildContext context,
    required String addressId, // ID của địa chỉ cần cập nhật
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
          'addressId': addressId, // Gửi ID của địa chỉ cần cập nhật
          ...addressData, // Sử dụng spread operator để thêm dữ liệu địa chỉ
        }),
      );

      if (res.statusCode == 200) {
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
      } else {
        // Xử lý các trường hợp không thành công
        final errorData = jsonDecode(res.body);
        showSnackBar(context, errorData['message'] ?? 'Có lỗi xảy ra.');
      }
    } catch (e) {
      // Xử lý lỗi từ phía client
      showSnackBar(context, e.toString());
    }
  }

  void deleteAddress({
    required BuildContext context,
    required String addressId, // ID của địa chỉ cần xóa
    required VoidCallback onSuccessfulDelete,
  }) async {
    print(addressId);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse(
            '$url/api/v2/auth/delete-address'), // Điều chỉnh endpoint cho phù hợp
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider
              .user.token, // Giả sử token được lưu trong userProvider
        },
        body: json.encode({
          'addressId': addressId, // Gửi ID của địa chỉ cần xóa
        }),
      );

      if (res.statusCode == 200) {
        // Cập nhật thông tin người dùng sau khi xóa địa chỉ thành công
        User user = userProvider.user
            .copyWith(addresses: jsonDecode(res.body)['addresses']);
        userProvider.setUserFromModel(user);
        print(user.addresses);
        TLoaders.succesSnackbar(
          title: 'Xóa địa chỉ thành công',
          message: 'Địa chỉ của bạn đã được xóa.',
        );
        onSuccessfulDelete();
      } else {
        // Xử lý các trường hợp không thành công
        final errorData = jsonDecode(res.body);
        showSnackBar(context, errorData['message'] ?? 'Có lỗi xảy ra.');
      }
    } catch (e) {
      // Xử lý lỗi từ phía client
      showSnackBar(context, e.toString());
    }
  }
}
