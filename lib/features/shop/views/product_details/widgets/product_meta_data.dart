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
  const TProductMetaData({
    Key? key,
    required this.product,
    this.isIconSale = false,
  }) : super(key: key);

  final Product product;
  final bool isIconSale;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        Positioned(
          top: -10,
          left: -10,
          child: isIconSale
              ? TRoundedContainer(
                  radius: TSizes.sm,
                  backgroundColor: TColors.secondary.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm,
                    vertical: TSizes.xs,
                  ),
                  child: Text(
                    'sale off 25%',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.black),
                  ),
                )
              : SizedBox.shrink(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTitleText(
              title: product.name.toString(),
              smallSize: false,
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                TBrandTitleWithVerifiedIcon(
                  title: 'Loại sản phẩm:',
                  brandTextSize: TextSizes.medium,
                ),
                SizedBox(width: TSizes.spaceBtwItems),
                TBrandTitleWithVerifiedIcon(
                  title: product.category.toString(),
                  brandTextSize: TextSizes.medium,
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                TProductPriceText(
                  price: product.sellPrice.toString(),
                  isLarge: true,
                ),
                SizedBox(width: TSizes.spaceBtwItems),
                SizedBox(width: TSizes.spaceBtwItems / 1.5),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: TSizes.spaceBtwItems / 2),
                    Text(
                      "Tồn Kho: ${product.stock.toString()} tồn kho",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Đã bán: ${product.sold_out.toString()} sản phẩm",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
