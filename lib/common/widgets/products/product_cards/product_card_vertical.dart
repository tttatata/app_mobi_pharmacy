import 'package:app_mobi_pharmacy/common/styles/shadows.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/product_provider.dart';
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
    int sumRate = 0;
    product.reviews?.forEach((e) {});
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
                  Positioned(
                    top: -10,
                    right: -10,
                    child: TCircularIcon(
                      onPressed: () {},
                      icon: Iconsax.heart, //icon chưa chọn
                      //  Iconsax.heart,//icon đã chọn
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                  )
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
                                                text: '5.0',
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
