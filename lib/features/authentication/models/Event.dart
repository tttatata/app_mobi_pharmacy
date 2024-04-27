// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_mobi_pharmacy/features/authentication/models/Image.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product_Reviews.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Shop_product.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final String unit;
  final DateTime startDate;
  final DateTime finishDate;
  final String status;
  final String tags;

  final int percentDiscount;
  final double discountPrice;
  final int stock;
  final List<Image_Product> images;

  final String shopId;
  final Shop_Product? shop;
  final int sold_out;
  final DateTime createdAt;
  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.stock,
    required this.brand,
    required this.discountPrice,
    required this.finishDate,
    required this.percentDiscount,
    required this.startDate,
    required this.images,
    required this.shopId,
    required this.shop,
    required this.sold_out,
    required this.unit,
    required this.tags,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'category': category,
      'stock': stock,
      'brand': brand,
      'discountPrice': discountPrice,
      'Finish_Date': finishDate,
      'percentDiscount': percentDiscount,
      'start_Date': startDate,
      'images': images,
      'shopId': shopId,
      'shop': shop,
      'sold_out': sold_out,
      'unit': unit,
      'tags': tags,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    if (map['_id'] == null || map['_id'].isEmpty) {
      throw Exception('Product ID is missing');
    }
    return Event(
      id: map['_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      brand: map['brand'] ?? '',
      unit: map['unit'] ?? '',
      discountPrice: map['discountPrice']?.toDouble() ?? 0,
      startDate: DateTime.parse(map['start_Date'] ?? ''),
      finishDate: DateTime.parse(map['Finish_Date'] ?? ''),
      tags: map['tags'] ?? '',
      status: map['status'] ?? '',
      percentDiscount: map['percentDiscount']?.toInt() ?? 0,
      stock: map['stock']?.toInt() ?? 0,
      images: List<Image_Product>.from(
        map['images']?.map(
          (x) => Image_Product?.fromMap(x),
        ),
      ),
      shopId: map['shopId'] ?? '',
      shop: map['shop'] != null ? new Shop_Product.fromMap(map['shop']) : null,
      sold_out: map['sold_out']?.toInt() ?? 0,
      createdAt: DateTime.parse(
        map['createdAt'] ?? '',
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
