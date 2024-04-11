import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:flutter/material.dart';

class ProductInherited extends InheritedWidget {
  final Product product;

  ProductInherited({
    Key? key,
    required this.product,
    required Widget child,
  }) : super(key: key, child: child);

  static ProductInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductInherited>();
  }

  @override
  bool updateShouldNotify(ProductInherited oldWidget) {
    return product != oldWidget.product;
  }
}
