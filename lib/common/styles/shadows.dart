import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:flutter/material.dart';

class TShadowStyle {
  static BoxShadow verticalProductShadow() {
    return BoxShadow(
      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
      blurRadius: 4,
      spreadRadius: 1,
      offset: Offset(0, 3),
    );
  }

  static BoxShadow horizontalProductShadow() {
    return BoxShadow(
      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
      blurRadius: 4,
      spreadRadius: 1,
      offset: Offset(0, 3),
    );
  }
}
