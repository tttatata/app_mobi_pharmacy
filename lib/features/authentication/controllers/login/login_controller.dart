import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/error/error_handling.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';

import 'package:app_mobi_pharmacy/features/shop/views/home/home.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginController {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$url/api/v2/auth/signin'), // Thay thế với URL backend của bạn
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        // Lưu trữ token nhận được vào SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = jsonDecode(res.body)['token'];
        print(token);
        await prefs.setString('x-auth-token', token);

        // Cập nhật thông tin người dùng trong UserProvider
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        final userProvider = context.read<UserProvider>().user.token;
        // Chuyển đến HomeScreen nếu đăng nhập thành công
        if (userProvider.isNotEmpty) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            NavigationMenu.routeName,
            (route) => false,
          );
        }
      } else {
        // Xử lý các trường hợp lỗi khác nhau dựa trên statusCode
        String errorMessage = jsonDecode(res.body)['message'];
        showSnackBar(context, errorMessage);
      }
    } catch (e) {
      // Hiển thị thông báo lỗi nếu có vấn đề khi giao tiếp với server
      showSnackBar(context, e.toString());
    }
  }

//get user data
  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$url/api/v2/auth/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$url/api/v2/auth/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
