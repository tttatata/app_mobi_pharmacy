import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_item.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: 4,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: TSizes.spaceBtwSections),
              itemBuilder: (_, index) => Column(
                    children: [
                      TCartItem(),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TCircularIcon(
                            icon: Iconsax.minus,
                            width: 32,
                            height: 32,
                            size: TSizes.md,
                            color: THelperFunctions.isDarkMode(context)
                                ? TColors.white
                                : TColors.black,
                            backgroundColor:
                                THelperFunctions.isDarkMode(context)
                                    ? TColors.darkerGrey
                                    : TColors.light,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text(
                            '2',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          TCircularIcon(
                            icon: Iconsax.add,
                            width: 32,
                            height: 32,
                            size: TSizes.md,
                            color: TColors.white,
                            backgroundColor: TColors.primary,
                          ),
                        ],
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}
