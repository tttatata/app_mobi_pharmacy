// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';

class Reviews_Product {
  final dynamic? user;
  final int? rating;
  final String? comment;
  final String? productId;
  final DateTime? createdAt;
  Reviews_Product({
    required this.user,
    required this.rating,
    required this.comment,
    required this.productId,
    required this.createdAt,
  });
  factory Reviews_Product.fromMap(Map<String, dynamic> json) {
    return Reviews_Product(
      user: json['user'],
      rating: json['rating'],
      comment: json['comment'],
      productId: json['productId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
