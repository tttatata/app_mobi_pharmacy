// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User2 {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User2({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory User2.fromMap(Map<String, dynamic> map) {
    return User2(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User2.fromJson(String source) => User2.fromMap(json.decode(source));

  User2 copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User2(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
