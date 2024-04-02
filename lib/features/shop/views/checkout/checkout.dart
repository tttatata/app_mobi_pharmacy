import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/coupon_widgets.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/shop/views/cart/widgents/cart_items.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
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
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///coupon text file
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    ///divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    TBillingAddressSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => SuccesScreen(
                image: TImages.successfulPaymentIcon,
                title: 'Payment Success!',
                subtitle: 'Your item will be shipped soon!',
                onPressed: () => Get.offAll(() => const NavigationMenu()),
              )),
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
