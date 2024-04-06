class Product {
  final String name;
  final String description;
  final String category;
  final String origin;
  final ImagesTitle images;
  // final String entryDate;
  // final String expiryDate;
  // final String quantity;
  // final String brand;
  // final String specifications;
  // final String unit;
  // final String ingredient;
  // final String weight;
  // final String material;
  // final String guarantee;
  // final double originalPrice;
  // final double vat;
  // final double sellPrice;
  // final double stock;
  Product({
    required this.description,
    required this.category,
    required this.origin,
    // required this.entryDate,
    // required this.expiryDate,
    // required this.quantity,
    // required this.brand,
    // required this.specifications,
    // required this.unit,
    // required this.ingredient,
    // required this.weight,
    // required this.material,
    // required this.guarantee,
    // required this.originalPrice,
    // required this.vat,
    // required this.sellPrice,
    // required this.stock,
    required this.name,
    required this.images,
  });
}

class ImagesTitle {
  final String public_id;
  final String url;
  final String id;
  ImagesTitle({
    required this.public_id,
    required this.url,
    required this.id,
  });
}
