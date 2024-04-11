import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Image_Product {
  final String? public_id;
  final String? url;
  Image_Product({
    this.public_id,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'public_id': public_id,
      'url': url,
    };
  }

  factory Image_Product.fromMap(Map<String, dynamic> map) {
    return Image_Product(
      public_id: map['public_id'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Image_Product.fromJson(String source) =>
      Image_Product.fromMap(json.decode(source));
}
