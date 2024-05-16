import 'dart:async';

import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/styles/shadows.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/sold_stock.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Event.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/product_details.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jiffy/jiffy.dart'; // Đả

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal(
      {super.key, this.product, this.isIconSale = false});
  final Product? product;

  final bool isIconSale;
  @override
  Widget build(BuildContext context) {
// Tạo biến để lưu giữ giá trị dựa vào isIconSale

// Sử dụng selectedProduct theo nhu cầu
// Ví dụ:

    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: product,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkGrey : TColors.softGrey,
            boxShadow: [TShadowStyle.horizontalProductShadow()],
          ),
          child: Column(
            children: [
              TRoundedContainer(
                height: 150,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: TRoundedImage(
                        fit: BoxFit.contain,
                        imageUrl: product!.images[0].url.toString(),
                        applyImageRadius: true,
                        isNetworkImage: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 172,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ProductTitleText(
                            title: product!.name,
                            smallSize: true,
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                        ],
                      ),
                      TBrandTitleWithVerifiedIcon(
                          title: product!.category.toString()),
                      Container(
                        // Đặt kích thước cho container nếu cần
                        width: double.infinity,
                        height: 60, // Ví dụ: chiều cao 200
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //price
                              Padding(
                                padding: EdgeInsets.only(left: TSizes.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Aligns children to the end (right side)
                                  children: [
                                    TProductPriceText(
                                        price: product!.sellPrice.toString()),
                                    const SizedBox(
                                      height: TSizes.spaceBtwItems / 2,
                                    ),
                                    Row(
                                      children: [
                                        TProductSoldText(
                                            sold: product!.sold_out.toString()),
                                        const SizedBox(
                                          width: TSizes.spaceBtwItems,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.star5,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: '5.0',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontSize: 12)),
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              '( ${product!.reviews!.length.toString()} )',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          8)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Other widgets...
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
