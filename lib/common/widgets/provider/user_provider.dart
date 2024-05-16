import 'dart:convert';

import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      phoneNumber: 0,
      addresses: [],
      role: '',
      token: '',
      avatar: null,
      cart: [],
      wishList: []);
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUser(int newPhoneNumber) {
    _user.phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  void clearUserData() {
    if (_user != null) {
      _user = User(
          id: '',
          name: '',
          email: '',
          password: '',
          phoneNumber: 0,
          addresses: [],
          role: '',
          token: '',
          avatar: null,
          cart: [],
          wishList: []); // Xóa dữ liệu người dùng
      notifyListeners();
    }
  }

  // xử lý địa chỉ khi chọn địa chỉ
  Map<String, dynamic>? _selectedAddress;
  Map<String, dynamic>? get selectedAddress => _selectedAddress;
  void setSelectedAddress(Map<String, dynamic> address) async {
    _selectedAddress = address;
    // Lưu vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedAddress', json.encode(address));
    notifyListeners();
  }

  Future<void> loadSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? addressJson = prefs.getString('selectedAddress');
    if (addressJson != null) {
      _selectedAddress = json.decode(addressJson);
      notifyListeners();
    }
  }
  //

  // xử lý phương thức thanh toán khi chọn
  Map<String, dynamic>? _selectedPaymentMethod;
  Map<String, dynamic>? get selectedPaymentMethod => _selectedPaymentMethod;
  void setSelectedPaymentMethod(Map<String, dynamic> paymentMethod) async {
    _selectedPaymentMethod = paymentMethod;
    // Lưu vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedPaymentMethod', json.encode(paymentMethod));
    notifyListeners();
  }

  Future<void> loadSelectedPaymentMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final String? paymentMethodJson = prefs.getString('selectedPaymentMethod');
    if (paymentMethodJson != null) {
      _selectedPaymentMethod = json.decode(paymentMethodJson);
      notifyListeners();
    }
  }
  //
}
