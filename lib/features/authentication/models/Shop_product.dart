import 'dart:convert';

class Shop_Product {
  final String id;
  final Avatar_shop? avatar;
  final String name;
  final String email;
  final String address;
  final int phoneNumber;
  final String role;
  final int zipCode;
  final int availableBalance;
  final String description;
  Shop_Product({
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.role,
    required this.zipCode,
    required this.availableBalance,
    required this.description,
    required this.id,
    this.avatar,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'role': role,
      'zipCode': zipCode,
      'availableBalance': availableBalance,
      'description': description,
      'id': id,
      'avatar': avatar,
    };
  }

  factory Shop_Product.fromMap(Map<String, dynamic> map) {
    return Shop_Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      role: map['role'] ?? '',
      zipCode: map['zipCode']?.toInt() ?? 0,
      availableBalance: map['availableBalance']?.toInt() ?? 0,
      id: map['_id'],
      avatar:
          map['avatar'] != null ? new Avatar_shop.fromMap(map['avatar']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop_Product.fromJson(String source) =>
      Shop_Product.fromMap(json.decode(source));
}

class Avatar_shop {
  final String public_id;
  final String url;
  Avatar_shop({
    required this.public_id,
    required this.url,
  });
  Map<String, dynamic> toMap() {
    return {
      ' public_id': public_id,
      'url': url,
    };
  }

  factory Avatar_shop.fromMap(Map<String, dynamic> map) {
    return Avatar_shop(
      public_id: map['public_id'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Avatar_shop.fromJson(String source) =>
      Avatar_shop.fromMap(json.decode(source));
}
