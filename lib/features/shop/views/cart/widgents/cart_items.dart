import 'package:app_mobi_pharmacy/common/widgets/products/cart/add_remove_button.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_item.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TCartItems extends StatelessWidget {
  const TCartItems(
      {super.key,
      this.showAddRemoveButtons = true,
      required this.onCartItemsChanged});
  final bool showAddRemoveButtons;
  final Function(List<Map<String, dynamic>>)
      onCartItemsChanged; // Thêm callback này

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    List<Map<String, dynamic>> cartItems = [];
    int sum = 0;
    user.cart?.forEach((e) {
      final price = e['product']['sellPrice'];
      if (price != null) {
        sum += e['quantity'] * (price as int) as int; // Convert to double
      }
    });
    // Tính toán và lấy thông tin giỏ hàng...
    user.cart?.forEach((e) {
      // Cập nhật thông tin sản phẩm với quantity mới
      e['product']['qty'] = e['quantity'];
      cartItems.add(e['product']); // Thêm thông tin sản phẩm vào danh sách
    });
    // Gọi callback với thông tin giỏ hàng đã cập nhật
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onCartItemsChanged(cartItems);
    });

    return ListView.separated(
        shrinkWrap: true,
        itemCount: user.cart!.length,
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
