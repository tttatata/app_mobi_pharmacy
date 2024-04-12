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
  final num? sellPrice;
  final num? stock;
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
      images: List<Image_Product>.from(
        map['images']?.map(
          (x) => Image_Product?.fromMap(x),
        ),
      ),
      reviews: map['reviews'] != null
          ? List<Reviews_Product>.from(
              map['reviews']?.map(
                (x) => Reviews_Product?.fromMap(x),
              ),
            )
          : null,
      ratings: map['ratings']?.toInt() ?? 0,
      shopId: map['shopId'] ?? '',
      shop: map['shop'] != null ? new Shop_Product.fromMap(map['shop']) : null,
      sold_out: map['sold_out']?.toInt() ?? 0,
      createdAt: DateTime.parse(
        map['createdAt'] ?? '',
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
// import 'dart:convert';

// Products productsFromJson(String str) => Products.fromJson(json.decode(str));

// String productsToJson(Products data) => json.encode(data.toJson());

// class Products {
//   String? id;
//   String? name;
//   String? description;
//   String? category;
//   String? origin;
//   dynamic entryDate;
//   dynamic expiryDate;
//   String? quantity;
//   String? brand;
//   String? specifications;
//   String? unit;
//   String? ingredient;
//   String? weight;
//   String? material;
//   String? guarantee;
//   int? originalPrice;
//   int? vat;
//   int? sellPrice;
//   int? stock;
//   List<Image>? images;
//   String? shopId;
//   Shop? shop;
//   int? soldOut;
//   DateTime? createdAt;
//   List<dynamic>? reviews;
//   int? v;

//   Products({
//     this.id,
//     this.name,
//     this.description,
//     this.category,
//     this.origin,
//     this.entryDate,
//     this.expiryDate,
//     this.quantity,
//     this.brand,
//     this.specifications,
//     this.unit,
//     this.ingredient,
//     this.weight,
//     this.material,
//     this.guarantee,
//     this.originalPrice,
//     this.vat,
//     this.sellPrice,
//     this.stock,
//     this.images,
//     this.shopId,
//     this.shop,
//     this.soldOut,
//     this.createdAt,
//     this.reviews,
//     this.v,
//   });

//   factory Products.fromJson(Map<String, dynamic> json) => Products(
//         id: json["_id"],
//         name: json["name"],
//         description: json["description"],
//         category: json["category"],
//         origin: json["origin"],
//         entryDate: json["entryDate"],
//         expiryDate: json["expiryDate"],
//         quantity: json["quantity"],
//         brand: json["brand"],
//         specifications: json["specifications"],
//         unit: json["unit"],
//         ingredient: json["ingredient"],
//         weight: json["weight"],
//         material: json["material"],
//         guarantee: json["guarantee"],
//         originalPrice: json["originalPrice"],
//         vat: json["vat"],
//         sellPrice: json["sellPrice"],
//         stock: json["stock"],
//         images: json["images"] == null
//             ? []
//             : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//         shopId: json["shopId"],
//         shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
//         soldOut: json["sold_out"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         reviews: json["reviews"] == null
//             ? []
//             : List<dynamic>.from(json["reviews"]!.map((x) => x)),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "description": description,
//         "category": category,
//         "origin": origin,
//         "entryDate": entryDate,
//         "expiryDate": expiryDate,
//         "quantity": quantity,
//         "brand": brand,
//         "specifications": specifications,
//         "unit": unit,
//         "ingredient": ingredient,
//         "weight": weight,
//         "material": material,
//         "guarantee": guarantee,
//         "originalPrice": originalPrice,
//         "vat": vat,
//         "sellPrice": sellPrice,
//         "stock": stock,
//         "images": images == null
//             ? []
//             : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "shopId": shopId,
//         "shop": shop?.toJson(),
//         "sold_out": soldOut,
//         "createdAt": createdAt?.toIso8601String(),
//         "reviews":
//             reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
//         "__v": v,
//       };
// }

// class Image {
//   String? publicId;
//   String? url;
//   String? id;

//   Image({
//     this.publicId,
//     this.url,
//     this.id,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         publicId: json["public_id"],
//         url: json["url"],
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "public_id": publicId,
//         "url": url,
//         "_id": id,
//       };
// }

// class Shop {
//   Avatar? avatar;
//   String? id;
//   String? name;
//   String? email;
//   String? address;
//   int? phoneNumber;
//   String? role;
//   int? zipCode;
//   int? availableBalance;
//   DateTime? createdAt;
//   List<dynamic>? transections;
//   int? v;
//   String? description;

//   Shop({
//     this.avatar,
//     this.id,
//     this.name,
//     this.email,
//     this.address,
//     this.phoneNumber,
//     this.role,
//     this.zipCode,
//     this.availableBalance,
//     this.createdAt,
//     this.transections,
//     this.v,
//     this.description,
//   });

//   factory Shop.fromJson(Map<String, dynamic> json) => Shop(
//         avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
//         id: json["_id"],
//         name: json["name"],
//         email: json["email"],
//         address: json["address"],
//         phoneNumber: json["phoneNumber"],
//         role: json["role"],
//         zipCode: json["zipCode"],
//         availableBalance: json["availableBalance"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         transections: json["transections"] == null
//             ? []
//             : List<dynamic>.from(json["transections"]!.map((x) => x)),
//         v: json["__v"],
//         description: json["description"],
//       );

//   Map<String, dynamic> toJson() => {
//         "avatar": avatar?.toJson(),
//         "_id": id,
//         "name": name,
//         "email": email,
//         "address": address,
//         "phoneNumber": phoneNumber,
//         "role": role,
//         "zipCode": zipCode,
//         "availableBalance": availableBalance,
//         "createdAt": createdAt?.toIso8601String(),
//         "transections": transections == null
//             ? []
//             : List<dynamic>.from(transections!.map((x) => x)),
//         "__v": v,
//         "description": description,
//       };
// }

// class Avatar {
//   String? publicId;
//   String? url;

//   Avatar({
//     this.publicId,
//     this.url,
//   });

//   factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
//         publicId: json["public_id"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "public_id": publicId,
//         "url": url,
//       };
// }
