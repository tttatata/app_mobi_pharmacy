// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // import 'dart:convert';
// // import 'dart:html';

// // class UserModel {
// //   final String id;
// //   final String name;
// //   final String email;
// //   final String password;
// //   final String phone;
// //   final String address;
// //   final String type;
// //   final String token;

// //   UserModel({
// //     required this.id,
// //     required this.name,
// //     required this.email,
// //     required this.password,
// //     required this.phone,
// //     required this.address,
// //     required this.type,
// //     required this.token,
// //   });
// //   static UserModel empty() => UserModel(
// //       id: '',
// //       name: '',
// //       email: '',
// //       password: '',
// //       phone: '',
// //       address: '',
// //       type: '',
// //       token: '');

// //   Map<String, dynamic> toJson() {
// //     return <String, dynamic>{
// //       'id': id,
// //       'name': name,
// //       'email': email,
// //       'password': password,
// //       'phone': phone,
// //       'address': address,
// //       'type': type,
// //       'token': token,
// //     };
// //   }
// // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String ,dynamic>> document){

// //   if(document.data()!=null){
// //     final data = document.data()!;
// //     return UserModel(id: document.id, name: data['name'], email: data['email'], password: data['email'], phone: data['email'], address: address, type: type, token: token)
// // }

// // }
// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:app_mobi_pharmacy/features/authentication/models/Address.dart';

// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String password;
//   final String phoneNumber;
//   final List<Address>? address;
//   final String role;
//   final String avatar;
//   final String token;
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.phoneNumber,
//     this.address,
//     required this.role,
//     required this.avatar,
//     required this.token,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'avatar': avatar,
//       'email': email,
//       'password': password,
//       'phone': phoneNumber,
//       'address': address,
//       'token': token,
//       'role': role,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['_id'] ?? '',
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       password: map['password'] ?? '',
//       avatar: map['avatar'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       token: map['token'] ?? '',
//       role: map['role'] ?? '',
//       address: map['address'] != null
//           ? List<Address>.from(
//               map['address']?.map(
//                 (x) => Address.fromMap(x),
//               ),
//             )
//           : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source));
// }
import 'dart:convert';

import 'package:app_mobi_pharmacy/features/authentication/models/Address.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final int phoneNumber;
  final List<dynamic> addresses;
  final String role;
  final dynamic avatar;
  final String token;

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
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'addresses': addresses,
      'role': role,
      'avatar': avatar,
      'token': token,
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
      avatar: map['avatar'],
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
    dynamic? avatar,
    String? token,
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
    );
  }
}
// class Address {
//   final String country;
//   final String city;
//   final String address1;
//   final String address2;
//   final int zipCode;
//   final String addressType;

//   Address({
//     required this.country,
//     required this.city,
//     required this.address1,
//     required this.address2,
//     required this.zipCode,
//     required this.addressType,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'country': country,
//       'city': city,
//       'address1': address1,
//       'address2': address2,
//       'zipCode': zipCode,
//       'addressType': addressType,
//     };
//   }

//   factory Address.fromMap(Map<String, dynamic> map) {
//     return Address(
//       country: map['country'],
//       city: map['city'],
//       address1: map['address1'],
//       address2: map['address2'],
//       zipCode: map['zipCode'],
//       addressType: map['addressType'],
//     );
//   }
// }

// class Avatar {
//   final String publicId;
//   final String url;

//   Avatar({
//     required this.publicId,
//     required this.url,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'publicId': publicId,
//       'url': url,
//     };
//   }

//   factory Avatar.fromMap(Map<String, dynamic> map) {
//     return Avatar(
//       publicId: map['publicId'],
//       url: map['url'],
//     );
//   }
// }
