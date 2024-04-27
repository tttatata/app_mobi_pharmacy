import 'package:app_mobi_pharmacy/common/widgets/brands/brand_show_case.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTabs extends StatelessWidget {
  const TCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const NeverScrollableScrollPhysics(), children: [
      Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TBrandShowCase(images: [
              TImages.productImage17,
              TImages.productImage18,
              TImages.productImage19,
            ]),
            const SizedBox(height: TSizes.spaceBtwItems),
            TSetionHeading(
              title: 'You might like',
              onPressed: () {},
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            // TGidLayout(
            //     itemCount: 4,
            //     itemBuilder: (_, index) => 
            //     const TProductCardVertical()
            //     )
          ],
        ),
      ),
    ]);
  }
}
