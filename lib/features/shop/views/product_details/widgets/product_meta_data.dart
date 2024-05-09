import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/enums.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final Product product;
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
        ProductTitleText(
          title: product.name.toString(),
          smallSize: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1,
        ),
        Row(
          children: [
            TBrandTitleWithVerifiedIcon(
              title: 'Loại sản phẩm:',
              brandTextSize: TextSizes.medium,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            TBrandTitleWithVerifiedIcon(
              title: product.category.toString(),
              brandTextSize: TextSizes.medium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1,
        ),
        Row(
          children: [
            TProductPriceText(
              price: product.sellPrice.toString(),
              isLarge: true,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              product.originalPrice.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 1.5,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1,
        ),

        ///stack status
        Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  "Tồn Kho: ${product.stock.toString()}\ttồn kho",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Đã bán: ${product.sold_out.toString()}\tsản phẩm",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),

        ///brand
      ],
    );
  }
}
