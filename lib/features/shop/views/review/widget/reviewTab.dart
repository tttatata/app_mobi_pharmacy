import 'package:app_mobi_pharmacy/common/widgets/brands/brand_show_case.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/widgets/orders_list.dart';
import 'package:app_mobi_pharmacy/features/shop/views/review/widget/reviewList.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TReviewTabs extends StatelessWidget {
  final String reviewStatus;

  const TReviewTabs({
    super.key,
    required this.reviewStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(physics: NeverScrollableScrollPhysics(), children: [
      Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TReviewListItems(
              reviewStatus: reviewStatus,
            ), // Truyền orderStatus vào đây
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    ]);
  }
}
