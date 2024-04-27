import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/styles/shadows.dart';
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

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal(
      {super.key, this.product, this.isIconSale = false, this.productEvent});
  final Product? product;
  final Event? productEvent;
  final bool isIconSale;
  @override
  Widget build(BuildContext context) {
// Tạo biến để lưu giữ giá trị dựa vào isIconSale
    dynamic selectedProduct;

    if (isIconSale) {
      selectedProduct = productEvent;
    } else {
      selectedProduct = product;
    }

// Sử dụng selectedProduct theo nhu cầu
// Ví dụ:
    if (selectedProduct is Product) {
      // Xử lý khi selectedProduct là sản phẩm chính
      print('Đây là sản phẩm chính: ${selectedProduct.name}');
    } else if (selectedProduct is Event) {
      // Xử lý khi selectedProduct là sản phẩm khuyến mãi
      print('Đây là sản phẩm khuyến mãi: ${selectedProduct.name}');
    }
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
        padding: const EdgeInsets.all(0),
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkGrey : TColors.softGrey,
            boxShadow: [TShadowStyle.horizontalProductShadow()],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            color: Colors.deepPurple,
            child: 
            Row(
              children: [
                Container(
                  child: 
                  TRoundedContainer(
                    height: 150,
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: TRoundedImage(
                            fit: BoxFit.contain,
                            imageUrl: selectedProduct is Product
                                ? selectedProduct!.images[0].url.toString()
                                : selectedProduct!.images[0].url.toString(),
                            isNetworkImage: true,
                            applyImageRadius: true,
                          ),
                        ),
                        Positioned(
                          child: isIconSale == false
                              ? TRoundedContainer(
                                  radius: TSizes.sm,
                                  backgroundColor:
                                      TColors.secondary.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.sm,
                                      vertical: TSizes.xs),
                                  child: Text('25%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(color: TColors.black)),
                                )
                              : Text(''),
                        ),
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: TCircularIcon(
                            icon: Iconsax.heart5,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
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
                              title: selectedProduct is Product
                                  ? selectedProduct!.name
                                  : selectedProduct!.name,
                              smallSize: true,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems / 2,
                            ),
                          ],
                        ),
                        TBrandTitleWithVerifiedIcon(
                            title: selectedProduct is Product
                                ? selectedProduct!.category.toString()
                                : selectedProduct!.category.toString()),
                        const Spacer(),
                        Container(
                          color: Colors.amberAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //price
                              Flexible(
                                child: TProductPriceText(
                                    price: selectedProduct is Product
                                        ? selectedProduct!.sellPrice.toString()
                                        : selectedProduct!.discountPrice
                                            .toString()),
                              ),
                              SizedBox(
                                height: TSizes.spaceBtwItems / 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
