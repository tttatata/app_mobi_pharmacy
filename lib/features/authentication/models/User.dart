import 'dart:convert';

import 'package:app_mobi_pharmacy/features/authentication/models/Address.dart';

class User {
  final String id;
  String name;
  final String email;
  String password;
  int phoneNumber;
  List<dynamic> addresses;
  final String role;
  Avatar_user? avatar;
  String token;
  List<dynamic>? cart;
  List<dynamic>? wishList;
  // Thêm thuộc tính đối tượng cho phương thức thanh toán
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.addresses,
    required this.role,
    required this.token,
    this.avatar,
    required this.cart,
    required this.wishList,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'addresses': addresses,
      'role': role,
      'avatar': avatar,
      'token': token,
      'cart': cart,
      'wishList': wishList,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      addresses: List<Map<String, dynamic>>.from(
        map['addresses']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      role: map['role'],
      avatar: map['avatar'] != null ? Avatar_user.fromMap(map['avatar']) : null,
      cart: map['cart'] != null
          ? List<Map<String, dynamic>>.from(
              map['cart']?.map(
                (x) => Map<String, dynamic>.from(x),
              ),
            )
          : [],
      wishList: map['wishList'] != null
          ? List<Map<String, dynamic>>.from(
              map['wishList']?.map(
                (x) => Map<String, dynamic>.from(x),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
//Đảm bảo rằng bạn cũng cập nhật phương thức copyWith để có thể tạo bản sao của đối tượng User với các thuộc tính mới được thay đổi:
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    int? phoneNumber,
    List<dynamic>? addresses,
    String? role,
    Avatar_user? avatar,
    String? token,
    List<dynamic>? cart,
    List<dynamic>? wishList,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addresses: addresses ?? this.addresses,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      wishList: wishList ?? this.wishList,
    );
  }
}

class Avatar_user {
  final String public_id;
  final String url;
  Avatar_user({
    required this.public_id,
    required this.url,
  });
  Map<String, dynamic> toMap() {
    return {
      ' public_id': public_id,
      'url': url,
    };
  }

  factory Avatar_user.fromMap(Map<String, dynamic> map) {
    return Avatar_user(
      public_id: map['public_id'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Avatar_user.fromJson(String source) =>
      Avatar_user.fromMap(json.decode(source));
}
