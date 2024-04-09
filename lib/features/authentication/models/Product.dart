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
  final DateTime entryDate;
  final DateTime expiryDate;
  final String tags;
  final String quantity;
  final String brand;
  final String specifications;
  final String unit;
  final String ingredient;
  final String weight;
  final String material;
  final String guarantee;
  final double originalPrice;
  final double vat;
  final double sellPrice;
  final int stock;
  final List<Image_Product> images;
  final List<Reviews_Product> reviews;
  final int ratings;
  final String shopId;
  final Shop_Product shop;
  final int sold_out;
  final DateTime createdAt;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.origin,
    required this.entryDate,
    required this.expiryDate,
    required this.tags,
    required this.quantity,
    required this.brand,
    required this.specifications,
    required this.unit,
    required this.ingredient,
    required this.weight,
    required this.material,
    required this.guarantee,
    required this.originalPrice,
    required this.vat,
    required this.sellPrice,
    required this.stock,
    required this.images,
    required this.reviews,
    required this.ratings,
    required this.shopId,
    required this.shop,
    required this.sold_out,
    required this.createdAt,
  });

  // factory Product.fromJson(Map<String, dynamic> e) {
  //   final images = (e['images'] as List)
  //       .map((item) => Image_Product.fromMap(item))
  //       .toList();
  //   final reviews = (e['reviews'] as List)
  //       .map((item) => Reviews_Product.fromMap(item))
  //       .toList();
  //   final shop = Shop_Product.fromMap(e['shop']);
  //   return Product(
  //     id: e['id'],
  //     name: e['name'],
  //     description: e['description'],
  //     category: e['category'],
  //     origin: e['origin'] as String,
  //     entryDate: DateTime.fromMillisecondsSinceEpoch(e['entryDate'] as int),
  //     expiryDate: DateTime.fromMillisecondsSinceEpoch(e['expiryDate'] as int),
  //     tags: e['tags'],
  //     quantity: e['quantity'],
  //     brand: e['brand'],
  //     specifications: e['specifications'],
  //     unit: e['unit'],
  //     ingredient: e['ingredient'],
  //     weight: e['weight'],
  //     material: e['material'],
  //     guarantee: e['guarantee'],
  //     originalPrice: e['originalPrice'],
  //     vat: e['vat'],
  //     sellPrice: e['sellPrice'],
  //     stock: e['stock'],
  //     images: images,
  //     reviews: reviews,
  //     ratings: e['ratings'] as int,
  //     shopId: e['shopId'] as String,
  //     shop: shop,
  //     sold_out: e['sold_out'] as int,
  //     createdAt: DateTime.fromMillisecondsSinceEpoch(e['createdAt'] as int),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'origin': origin,
      'entryDate': entryDate.millisecondsSinceEpoch,
      'expiryDate': expiryDate.millisecondsSinceEpoch,
      'tags': tags,
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
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      origin: map['origin'] as String,
      entryDate: DateTime.fromMillisecondsSinceEpoch(map['entryDate'] as int),
      expiryDate: DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int),
      tags: map['tags'] as String,
      quantity: map['quantity'] as String,
      brand: map['brand'] as String,
      specifications: map['specifications'] as String,
      unit: map['unit'] as String,
      ingredient: map['ingredient'] as String,
      weight: map['weight'] as String,
      material: map['material'] as String,
      guarantee: map['guarantee'] as String,
      originalPrice: map['originalPrice'] as double,
      vat: map['vat'] as double,
      sellPrice: map['sellPrice'] as double,
      stock: map['stock'] as int,
      images: List<Image_Product>.from(
        (map['images'] as List<int>).map<Image_Product>(
          (x) => Image_Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      reviews: List<Reviews_Product>.from(
        (map['reviews'] as List<int>).map<Reviews_Product>(
          (x) => Reviews_Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      ratings: map['ratings'] as int,
      shopId: map['shopId'] as String,
      shop: Shop_Product.fromMap(map['shop'] as Map<String, dynamic>),
      sold_out: map['sold_out'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? origin,
    DateTime? entryDate,
    DateTime? expiryDate,
    String? tags,
    String? quantity,
    String? brand,
    String? specifications,
    String? unit,
    String? ingredient,
    String? weight,
    String? material,
    String? guarantee,
    double? originalPrice,
    double? vat,
    double? sellPrice,
    int? stock,
    List<Image_Product>? images,
    List<Reviews_Product>? reviews,
    int? ratings,
    String? shopId,
    Shop_Product? shop,
    int? sold_out,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      origin: origin ?? this.origin,
      entryDate: entryDate ?? this.entryDate,
      expiryDate: expiryDate ?? this.expiryDate,
      tags: tags ?? this.tags,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
      specifications: specifications ?? this.specifications,
      unit: unit ?? this.unit,
      ingredient: ingredient ?? this.ingredient,
      weight: weight ?? this.weight,
      material: material ?? this.material,
      guarantee: guarantee ?? this.guarantee,
      originalPrice: originalPrice ?? this.originalPrice,
      vat: vat ?? this.vat,
      sellPrice: sellPrice ?? this.sellPrice,
      stock: stock ?? this.stock,
      images: images ?? this.images,
      reviews: reviews ?? this.reviews,
      ratings: ratings ?? this.ratings,
      shopId: shopId ?? this.shopId,
      shop: shop ?? this.shop,
      sold_out: sold_out ?? this.sold_out,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, category: $category, origin: $origin, entryDate: $entryDate, expiryDate: $expiryDate, tags: $tags, quantity: $quantity, brand: $brand, specifications: $specifications, unit: $unit, ingredient: $ingredient, weight: $weight, material: $material, guarantee: $guarantee, originalPrice: $originalPrice, vat: $vat, sellPrice: $sellPrice, stock: $stock, images: $images, reviews: $reviews, ratings: $ratings, shopId: $shopId, shop: $shop, sold_out: $sold_out, createdAt: $createdAt)';
  }
}
 // factory Product.fromJson(Map<String, dynamic> json) {
  //   final List<dynamic> imageList = json['images'];
  //   final List<Image> parsedImages =
  //       imageList.map((imageJson) => Image.fromjson(imageJson)).toList();
  //   return Product(
  //     id: json['id'] as String,
  //     name: json['name'] as String,
  //     description: json['description'] as String,
  //     category: json['category'] as String,
  //     origin: json['origin'] as String,
  //     entryDate: DateTime.fromMillisecondsSinceEpoch(json['entryDate'] as int),
  //     expiryDate:
  //         DateTime.fromMillisecondsSinceEpoch(json['expiryDate'] as int),
  //     tags: json['tags'] as String,
  //     quantity: json['quantity'] as String,
  //     brand: json['brand'] as String,
  //     specifications: json['specifications'] as String,
  //     unit: json['unit'] as String,
  //     ingredient: json['ingredient'] as String,
  //     weight: json['weight'] as String,
  //     material: json['material'] as String,
  //     guarantee: json['guarantee'] as String,
  //     originalPrice: json['originalPrice'] as String,
  //     vat: json['vat'] as double,
  //     sellPrice: json['sellPrice'] as double,
  //     stock: json['stock'] as int,

  //     ratings: json['ratings'] as int,
  //     shopId: json['shopId'] as String,
  //     sold_out: json['sold_out'] as int,
  //     price: json['price'] as double,
  //   );
  // }

