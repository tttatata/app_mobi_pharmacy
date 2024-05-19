import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_item.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/checkout.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final userchecked =
        Provider.of<UserProvider>(context).user.token.isNotEmpty;
    final darkMode = THelperFunctions.isDarkMode(context);
    double sum = 0.0;
    user.cart?.forEach((e) {
      final price = e['sellPrice'];
      if (price != null) {
        sum += e['qty'] * (price as int).toDouble(); // Convert to double
      }
    });

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Giỏ hàng',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.cart!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: TCartItem(
                      index: index,
                    ));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: userchecked
            ? ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Text(TFormatter.formatCurrency(sum)),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace,
                    vertical: TSizes.defaultSpace / 2),
                decoration: BoxDecoration(
                  color: darkMode ? TColors.darkGrey : TColors.light,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(TSizes.cardRadiusLg),
                    topRight: Radius.circular(TSizes.cardRadiusLg),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đăng nhập để tiếp tục',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (route) => true,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(TSizes.md),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 255, 15, 15))),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
