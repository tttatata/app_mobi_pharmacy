import 'package:app_mobi_pharmacy/common/widgets/products/productrow/row_product_category.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/util/constans/category.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class TRowProductCategory extends StatelessWidget {
  const TRowProductCategory({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
        child: Column(
          children: [
            TSetionHeading(
              title: category,
              onPressed: () {},
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            RowProductCateggory(
              category: category,
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),
          ],
        ),
      ),
    );
  }
}
