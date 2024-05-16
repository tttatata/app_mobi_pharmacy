import 'package:app_mobi_pharmacy/common/styles/shadows.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';

import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/sold_stock.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/product_details.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/widgets/rating_share_widget.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/enums.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/common/styles/shadows.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical(
      {super.key, required this.product, this.isIconSale = false});
  final Product product;
  final bool isIconSale;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double sumRatings = 0;
    int totalReviews = 0;

    // Tính toán đánh giá trung bình
    double averageRating = 0; // Khai báo biến ở đây để có thể sử dụng sau này

    if (product.reviews != null && product.reviews!.isNotEmpty) {
      product.reviews!.forEach((review) {
        sumRatings += review.rating ?? 0;
        totalReviews++;
      });

      if (totalReviews > 0) {
        averageRating = sumRatings / totalReviews;
      }
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: product,
        );
      },
      child: Container(
        width: 180,
        height: 300,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
          boxShadow: [TShadowStyle.verticalProductShadow()],
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  TRoundedImage(
                    fit: BoxFit.contain,
                    imageUrl: product.images[0].url.toString(),
                    isNetworkImage: true,
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: -10,
                    left: -10,
                    child: isIconSale == true
                        ? TRoundedContainer(
                            radius: TSizes.sm,
                            backgroundColor: TColors.secondary.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.sm, vertical: TSizes.xs),
                            child: Text('sale off 25%',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(color: TColors.black)),
                          )
                        : Text(''),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),

            ///detail
            ///
            Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTitleText(
                      title: product.name,
                      smallSize: true,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TBrandTitleWithVerifiedIcon(
                      title: product.category,
                      brandTextSize: TextSizes.small,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Column(
              children: [
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
                                  price: product.sellPrice.toString()),
                              const SizedBox(
                                height: TSizes.spaceBtwItems / 2,
                              ),
                              Row(
                                children: [
                                  TProductSoldText(
                                      sold: product.sold_out.toString()),
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
                                                text: averageRating
                                                    .toStringAsFixed(1),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 12)),
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '( ${product.reviews!.length.toString()} )',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(fontSize: 8)),
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
            )
          ],
        ),
      ),
    );
  }
}
