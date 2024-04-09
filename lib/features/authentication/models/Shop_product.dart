class Shop_Product {
  final Avatar_shop avatar_shop;

  Shop_Product({
    required this.avatar_shop,
  });
  factory Shop_Product.fromMap(Map<String, dynamic> json) {
    return Shop_Product(
      avatar_shop: json['avatar_shop'],
    );
  }
}

class Avatar_shop {
  final String public_id;
  final String url;
  Avatar_shop({
    required this.public_id,
    required this.url,
  });
  factory Avatar_shop.fromMap(Map<String, dynamic> json) {
    return Avatar_shop(
      public_id: json['public_id'],
      url: json['url'],
    );
  }
}
