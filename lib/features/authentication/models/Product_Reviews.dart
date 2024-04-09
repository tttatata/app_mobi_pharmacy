// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_mobi_pharmacy/features/authentication/models/User.dart';

class Reviews_Product {
  final User user_id;
  final int rating;
  final String productId;
  final DateTime createdAt;
  Reviews_Product({
    required this.user_id,
    required this.rating,
    required this.productId,
    required this.createdAt,
  });
  factory Reviews_Product.fromMap(Map<String, dynamic> json) {
    return Reviews_Product(
      user_id: json['user_id'],
      rating: json['rating'],
      productId: json['productId'],
      createdAt: json['createdAt'],
    );
  }
}
