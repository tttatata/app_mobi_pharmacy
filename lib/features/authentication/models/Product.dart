// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_mobi_pharmacy/features/authentication/models/Image.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product_Reviews.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Shop_product.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String origin;
  final String? quantity;
  final String? brand;
  final String? specifications;
  final String? unit;
  final String? ingredient;
  final String? weight;
  final String? material;
  final String? guarantee;
  final num? originalPrice;
  final num? vat;
  final double? sellPrice;
  final int? stock;
  final List<Image_Product> images;
  final List<Reviews_Product>? reviews;
  final num? ratings;
  final String shopId;
  final Shop_Product? shop;
  final num? sold_out;

  final DateTime? createdAt;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.origin,
    this.quantity,
    this.brand,
    this.specifications,
    this.unit,
    this.ingredient,
    this.weight,
    this.material,
    this.guarantee,
    this.originalPrice,
    this.vat,
    this.sellPrice,
    required this.stock,
    required this.images,
    required this.reviews,
    required this.ratings,
    required this.shopId,
    required this.shop,
    this.sold_out,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'category': category,
      'origin': origin,
      'quantity': quantity,
      'brand': brand,
      'specifications': specifications,
      'unit': unit,
      'ingredient': ingredient,
      'weight': weight,
      'material': material,
      'guarantee': guarantee,
      'originalPrice': originalPrice,
      'vat': vat,
      'sellPrice': sellPrice,
      'stock': stock,
      'images': images,
      'reviews': reviews,
      'ratings': ratings,
      'shopId': shopId,
      'shop': shop,
      'sold_out': sold_out,
      'createdAt': createdAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map['_id'] == null || map['_id'].isEmpty) {
      throw Exception('Product ID is missing');
    }
    return Product(
      id: map['_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      origin: map['origin'] ?? '',
      quantity: map['quantity'] ?? '',
      brand: map['brand'] ?? '',
      specifications: map['specifications'] ?? '',
      unit: map['unit'] ?? '',
      ingredient: map['ingredient'] ?? '',
      weight: map['weight'] ?? '',
      material: map['material'] ?? '',
      guarantee: map['guarantee'] ?? '',
      originalPrice: map['originalPrice']?.toDouble() ?? 0,
      vat: map['vat']?.toDouble() ?? 0,
      sellPrice: map['sellPrice']?.toDouble() ?? 0,
      stock: map['stock']?.toInt() ?? 0,
      images: (map['images'] as List<dynamic>?)
              ?.map((x) => Image_Product.fromMap(x))
              .toList() ??
          [],
      reviews: (map['reviews'] as List<dynamic>?)
              ?.map((x) => Reviews_Product.fromMap(x))
              .toList() ??
          [],
      ratings: map['ratings']?.toInt() ?? 0,
      shopId: map['shopId'] ?? '',
      shop: map['shop'] != null ? new Shop_Product.fromMap(map['shop']) : null,
      sold_out: map['sold_out']?.toInt() ?? 0,
      createdAt: DateTime.tryParse(
        map['createdAt'] ?? '',
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
