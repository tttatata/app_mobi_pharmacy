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
import 'package:bcrypt/bcrypt.dart';

class UserController {
  void updateUser({
    required BuildContext context,
// ID của người dùng cần cập nhật
    required Map<String, dynamic> userData, // Dữ liệu cập nhật cho người dùng
    required VoidCallback onSuccessfulUpdate,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$url/api/v2/auth/update-user'), // Endpoint cập nhật thông tin người dùng
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token, // Token của người dùng
        },
        body: json.encode({
          ...userData, // Sử dụng spread operator để thêm dữ liệu người dùng
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Cập nhật thông tin người dùng trong provider sau khi cập nhật thành công
          User user = userProvider.user.copyWith(
            // name: jsonDecode(res.body)['name'],
            // password: jsonDecode(res.body)['password'],
            phoneNumber: jsonDecode(res.body)['phoneNumber'],
            avatar: jsonDecode(res.body)['avatar'],
          );
          userProvider.setUserFromModel(user);
          TLoaders.succesSnackbar(
            title: 'Cập nhật thông tin thành công',
            message: 'Thông tin của bạn đã được cập nhật.',
          );
          onSuccessfulUpdate();
        },
      );
    } catch (e) {
      // Xử lý lỗi từ phía client
      showSnackBar(context, e.toString());
    }
  }

  // Phương thức kiểm tra mật khẩu hiện tại có đúng không
  // Phương thức kiểm tra mật khẩu hiện tại có đúng không
  Future<bool> validateCurrentPassword(
      BuildContext context, String currentPassword) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String storedHashedPassword =
        userProvider.user.password; // Mật khẩu đã mã hóa từ userProvider

    // Kiểm tra xem storedHashedPassword có phải là chuỗi rỗng hay không
    if (storedHashedPassword.isEmpty) {
      // Nếu rỗng, hiển thị lỗi hoặc xử lý tương ứng
      print('Lỗi: Mật khẩu đã mã hóa không được để trống.');
      return false;
    }

    // So sánh mật khẩu nhập vào với mật khẩu đã mã hóa
    bool isMatch = await BCrypt.checkpw(currentPassword, storedHashedPassword);
    print(isMatch);
    return isMatch;
  }
}
