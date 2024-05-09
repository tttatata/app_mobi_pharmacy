// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_mobi_pharmacy/features/authentication/models/Address.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_mobi_pharmacy/features/authentication/models/Image.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product_Reviews.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Shop_product.dart';

class Order {
  final String id;
  final List<dynamic>? cart;
  final Address? shippingAddress;
  final User? user;
  final num totalPrice;
  final String status;
  final dynamic? paymentInfo;
  final DateTime? paidAt;
  final DateTime? deliveredAt;
  final DateTime? createdAt;
  Order({
    required this.id,
    required this.cart,
    required this.shippingAddress,
    required this.user,
    required this.totalPrice,
    required this.status,
    required this.paymentInfo,
    required this.paidAt,
    required this.deliveredAt,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'cart': cart,
      'shippingAddress': shippingAddress,
      'user': user,
      'totalPrice': totalPrice,
      'status': status,
      'paymentInfo': paymentInfo,
      'paidAt': paidAt,
      'deliveredAt': deliveredAt,
      'createdAt': createdAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map['_id'] == null || map['_id'].isEmpty) {
      throw Exception(' Order ID is missing');
    }
    return Order(
      id: map['_id'],
      cart: map['cart'] != null
          ? List<Map<String, dynamic>>.from(
              map['cart']?.map(
                (x) => Map<String, dynamic>.from(x),
              ),
            )
          : [],
      shippingAddress: map['shippingAddress'] != null
          ? Address.fromMap(map['shippingAddress'])
          : null,
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      paymentInfo: map['paymentInfo'] != null ? map['paymentInfo'] : [],
      totalPrice: map['totalPrice']?.toDouble() ?? 0,
      status: map['status'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(
              map['createdAt'] ?? '',
            )
          : null,
      paidAt: map['paidAt'] != null
          ? DateTime.tryParse(
              map['paidAt'] ?? '',
            )
          : null,
      deliveredAt: map['deliveredAt'] != null
          ? DateTime.tryParse(
              map['deliveredAt'] ?? '',
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
