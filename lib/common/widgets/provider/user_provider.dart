import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: '',
    name: '',
    email: '',
    password: '',
    phoneNumber: '',
    address: [],
    avatar: '',
    role: '',
  );
  UserModel get user => _user;
  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
