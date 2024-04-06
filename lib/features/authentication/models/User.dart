// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'dart:html';

// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String password;
//   final String phone;
//   final String address;
//   final String type;
//   final String token;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.phone,
//     required this.address,
//     required this.type,
//     required this.token,
//   });
//   static UserModel empty() => UserModel(
//       id: '',
//       name: '',
//       email: '',
//       password: '',
//       phone: '',
//       address: '',
//       type: '',
//       token: '');

  

  

  

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'email': email,
//       'password': password,
//       'phone': phone,
//       'address': address,
//       'type': type,
//       'token': token,
//     };
//   }
// factory UserModel.fromSnapshot(DocumentSnapshot<Map<String ,dynamic>> document){
  
//   if(document.data()!=null){
//     final data = document.data()!;
//     return UserModel(id: document.id, name: data['name'], email: data['email'], password: data['email'], phone: data['email'], address: address, type: type, token: token)
// }

 
// }
 // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final List<dynamic> address;
  final String role;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.role,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'email': email,
      'password': password,
      'phone': phoneNumber,
      'address': address,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      avatar: map['avatar'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    List<dynamic>? address,
    String? role,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
    );
  }
}
