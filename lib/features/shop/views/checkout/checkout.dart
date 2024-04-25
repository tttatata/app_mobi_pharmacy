import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/coupon_widgets.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/paymentcontroller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/cart/widgents/cart_items.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_paymentmethod.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_user.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/card.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/paymentmethod.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// main.dart
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final paymentController = Get.put(PaymentController());
  List<Map<String, dynamic>> _cartItems = [];
  Map<String, dynamic>? paymentIntent;
  int _totalAmount = 0;
  final CheckOutServices _checkOutServices = CheckOutServices();
  void _handleCartItemsChanged(List<Map<String, dynamic>> cartItems) {
    setState(() {
      _cartItems = cartItems;
    });
  }

  void _updateTotalAmount(int amount) {
    // Phương thức để cập nhật tổng tiền
    setState(() {
      _totalAmount = amount;
    });
  }

  void _handleCheckoutButtonPressed(BuildContext context) async {
    if (Provider.of<UserProvider>(context, listen: false)
            .selectedPaymentMethod?['paymentMethod'] ==
        'COD') {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Xác nhận Đơn Hàng'),
            content: Text(
                'Bạn có chắc chắn muốn đặt hàng với tổng số tiền là \$${_totalAmount.toString()} không?'),
            actions: <Widget>[
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Đóng hộp thoại khi người dùng chọn hủy
                },
              ),
              TextButton(
                child: Text('Xác nhận'),
                onPressed: () {
                  // Gọi hàm tạo đơn hàng ở đây
                  _checkOutServices.createneworder(
                      context: context,
                      cartItems: _cartItems,
                      totalAmount: _totalAmount,
                      paynment: "Cash On Delivery");
                },
              ),
            ],
          );
        },
      );
    }
    if (Provider.of<UserProvider>(context, listen: false)
            .selectedPaymentMethod?['paymentMethod'] ==
        'Visa') {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Xác nhận Đơn Hàng'),
            content: Text(
                'Bạn có chắc chắn muốn đặt hàng với tổng số tiền là \$${_totalAmount.toString()} không?'),
            actions: <Widget>[
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Đóng hộp thoại khi người dùng chọn hủy
                },
              ),
              TextButton(
                child: Text('Xác nhận'),
                onPressed: () =>
                    paymentController.makePayment(amount: '5', currency: 'USD'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final user = context.watch<UserProvider>().user;

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
              TCartItems(
                showAddRemoveButtons: false,
                onCartItemsChanged: _handleCartItemsChanged,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///coupon text file
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    TBillingAmountSection(
                        onTotalAmountChanged: _updateTotalAmount),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    TBillingAddressSection(),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    TBillingUserSection(),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [TBillingPaymentMethodSection()],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => _handleCheckoutButtonPressed(context),
          // onPressed: () => Get.to(() => SuccesScreen(
          //       image: TImages.successfulPaymentIcon,
          //       title: 'Payment Success!',
          //       subtitle: 'Your item will be shipped soon!',
          //       onPressed: () => Get.offAll(() => const NavigationMenu()),
          //     )),
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
