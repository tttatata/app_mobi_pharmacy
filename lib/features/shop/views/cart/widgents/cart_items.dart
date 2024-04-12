import 'package:app_mobi_pharmacy/common/widgets/products/cart/add_remove_button.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_item.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 2,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) => Column(
              children: [
                TCartItem(index: index),
                if (showAddRemoveButtons)
                  const SizedBox(height: TSizes.spaceBtwItems),

                ///add remove button
                if (showAddRemoveButtons)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TProductQuantityWithAddRemoveButton(),
                        ],
                      ),
                      TProductPriceText(price: '222')
                    ],
                  )
              ],
            ));
  }
}
