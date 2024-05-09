import 'dart:convert';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/coupon_widgets.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Coupon.dart';
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
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// main.dart
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final paymentController = Get.put(PaymentController());
  Coupon? appliedCoupon; //
  List<Map<String, dynamic>> _cartItems = [];
  Map<String, dynamic>? paymentIntent;
  int _totalAmount = 0;
  final CheckOutServices _checkOutServices = CheckOutServices();
  void _handleCartItemsChanged(List<Map<String, dynamic>> cartItems) {
    setState(() {
      _cartItems = cartItems;
    });
  }

void _applyCoupon(Coupon coupon) {
  if (_totalAmount >= coupon.minAmount) {
    // Tính giá trị giảm giá dựa trên phần trăm của tổng tiền
    double discountPercent = coupon.value / 100;
    double discountValue = _totalAmount * discountPercent;

    // Đảm bảo rằng giá trị giảm giá không vượt quá maxAmount của coupon
    if (coupon.maxAmount != null && discountValue > coupon.maxAmount) {
      discountValue = coupon.maxAmount;
    }

    // Cập nhật tổng tiền sau khi áp dụng giảm giá
    _updateTotalAmount(_totalAmount - discountValue.round());
  } else {
    // Nếu tổng tiền không đủ điều kiện tối thiểu, hiển thị thông báo
    showSnackBar(context, 'Total amount does not meet the minimum requirement for the coupon.');
  }
}

void _updateTotalAmount(int newAmount) {
  setState(() {
    _totalAmount = newAmount;
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
                'Bạn có chắc chắn muốn đặt hàng với tổng số tiền là ${TFormatter.formatCurrency(_totalAmount.toDouble())} không?'),
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
                      payment: "Cash On Delivery");
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
                'Bạn có chắc chắn muốn đặt hàng với tổng số tiền là ${TFormatter.formatCurrency(_totalAmount.toDouble())} không?'),
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
                  paymentController.makePayment(
                      context: context,
                      totalAmount: _totalAmount.toInt(),
                      currency: 'VND',
                      cartItems: _cartItems,
                      payment: "Cash On Visa");
                },
              ),
            ],
          );
        },
      );
    }
    if (Provider.of<UserProvider>(context, listen: false)
            .selectedPaymentMethod?['paymentMethod'] ==
        'PayPal') {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Xác nhận Đơn Hàng'),
            content: Text(
                'Bạn có chắc chắn muốn đặt hàng với tổng số tiền là ${TFormatter.formatCurrency(_totalAmount.toDouble())} không?'),
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
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "AdyWwYhIBpVEXxPnfHj31osJ3uAuag8ZjLJ1DoqPIBA-CSiD91hpErkUXxxYFLYuIYeKcmqpxYTyqKqu",
                          secretKey:
                              "EH3vo4MivtwR1h1hJYm7QVYQgM-J_4U_AflsHYIuCWWTbSZfXxSF_EY-5GR1OuGXXCCQ0HXknmercyCU",
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: const [
                            {
                              "amount": {
                                "total": '10.12',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '10.12',
                                  "shipping": '0',
                                  "shipping_discount": "0"
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              "item_list": {
                                "items": [
                                  {
                                    "name": "A demo product",
                                    "quantity": 1,
                                    "price": '10.12',
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                "shipping_address": {
                                  "recipient_name": "Jane Foster",
                                  "line1": "Travis County",
                                  "line2": "",
                                  "city": "Austin",
                                  "country_code": "US",
                                  "postal_code": "73301",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          }),
                    ));
                  }),
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
          'Đặt hàng',
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
              TCouponCode(onCouponApplied: _applyCoupon), //
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
          child: Text(
            TFormatter.formatCurrency(_totalAmount.toDouble()),
          ),
        ),
      ),
    );
  }
}
