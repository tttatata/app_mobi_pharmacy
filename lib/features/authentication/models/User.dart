import 'dart:convert';

import 'package:app_mobi_pharmacy/features/authentication/models/Address.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final int phoneNumber;
  final List<dynamic>? addresses;
  final String role;
  final String? avatar;
  final String token;
  final List<dynamic>? cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.addresses,
    required this.role,
    required this.token,
    required this.avatar,
    required this.cart,
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
      avatar: map['avatar'] != null ? map['avatar']['url'] : null,
      cart: map['cart'] != null
          ? List<Map<String, dynamic>>.from(
              map['cart']?.map(
                (x) => Map<String, dynamic>.from(x),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    int? phoneNumber,
    List<dynamic>? addresses,
    String? role,
    String? avatar,
    String? token,
    List<dynamic>? cart,
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
