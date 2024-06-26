// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  final String country;
  final String city;
  final String address1;
  final String address2;
  final int zipCode;
  final String addressType;

  Address({
    required this.country,
    required this.city,
    required this.address1,
    required this.address2,
    required this.zipCode,
    required this.addressType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'city': city,
      'address1': address1,
      'address2': address2,
      'zipCode': zipCode,
      'addressType': addressType,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      zipCode: map['zipCode']?.toInt() ?? 0,
      addressType: map['addressType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);
}
