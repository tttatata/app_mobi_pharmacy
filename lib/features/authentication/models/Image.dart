import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Image_Product {
  final String public_id;
  final String url;
  Image_Product({
    required this.public_id,
    required this.url,
  });

  factory Image_Product.fromMap(Map<String, dynamic> json) {
    return Image_Product(
      public_id: json['public_id'],
      url: json['url'],
    );
  }
}
