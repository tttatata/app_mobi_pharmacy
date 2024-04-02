import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/enums.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TRoundedContainer(
          radius: TSizes.sm,
          backgroundColor: TColors.secondary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.sm, vertical: TSizes.xs),
          child: Text('sale off 25%',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.black)),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text(
          '\$250',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .apply(decoration: TextDecoration.lineThrough),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        const TProductPriceText(
          price: '35.5',
          isLarge: true,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems / 1.5,
        ),
        const ProductTitleText(
          title: 'product title 1 ',
          smallSize: true,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems / 1.5,
        ),

        ///stack status
        Row(
          children: [
            const ProductTitleText(
              title: 'status ',
              smallSize: true,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              'in Stock',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(
          width: TSizes.spaceBtwItems / 1.5,
        ),

        ///brand
        Row(
          children: [
            TCircularImage(
              image: TImages.shoeIcon,
              width: 32,
              height: 32,
              overlayColor: darkMode ? TColors.white : TColors.black,
            ),
            const TBrandTitleWithVerifiedIcon(
              title: 'Nike',
              brandTextSize: TextSizes.medium,
            )
          ],
        )
      ],
    );
  }
}
