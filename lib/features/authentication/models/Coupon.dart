import 'dart:convert';

class Coupon {
  final String id;

  final int value;
  final String name;

  final double minAmount;
  final double maxAmount;
  final DateTime? createdAt;
  Coupon({
    required this.id,
    required this.name,
    required this.value,
    required this.minAmount,
    required this.maxAmount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'createdAt': createdAt,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    if (map['_id'] == null || map['_id'].isEmpty) {
      throw Exception(' Coupon ID is missing');
    }
    return Coupon(
      id: map['_id'],
      name: map['name'] ?? '',
      value: map['value']?.toInt() ?? 0,
      minAmount: map['minAmount']?.toDouble() ?? 0,
      maxAmount: map[' maxAmount']?.toDouble() ?? 0,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(
              map['createdAt'] ?? '',
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupon.fromJson(String source) => Coupon.fromMap(json.decode(source));
}
