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
import 'package:app_mobi_pharmacy/features/shop/views/home/home.dart';
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
import 'package:forex_currency_conversion/forex_currency_conversion.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final paymentController = Get.put(PaymentController());
  Coupon? appliedCoupon; //
  List<Map<String, dynamic>> _cartItems = [];
  Map<String, dynamic>? paymentIntent;
  int _totalAmount = 0;
  int _salelAmount = 0;
  int _totalAmountUSD = 0;
  final CheckOutServices _checkOutServices = CheckOutServices();
  void _handleCartItemsChanged(List<Map<String, dynamic>> cartItems) {
    setState(() {
      _cartItems = cartItems;
    });
  }

  void _applyCoupon(Coupon coupon) {
    print('Coupon value: ${coupon.value}');
    if (_totalAmount >= coupon.minAmount) {
      print('Total amount before discount: $_totalAmount');
      double discountValue = (_totalAmount * 10.0) / 100;

      print('Calculated discount value: $discountValue');
      // Kiểm tra giá trị giảm giá tối đa
      if (coupon.maxAmount != null && discountValue > coupon.maxAmount) {
        discountValue = coupon.maxAmount;
      }
      print('Discount value after checking max amount: $discountValue');
      // Tính toán tổng tiền mới sau khi áp dụng giảm giá
      int newTotalAmount = _totalAmount - discountValue.floor();
      print(newTotalAmount);
      // Cập nhật tổng tiền mới
      _updateTotalAmount(newTotalAmount);

      // Cập nhật coupon đã áp dụng
      setState(() {
        appliedCoupon = coupon;
      });

      // Hiển thị thông báo áp dụng coupon thành công
      showSnackBar(
          context, 'Coupon applied successfully! New total: $newTotalAmount');
    } else {
      // Hiển thị thông báo nếu không đủ điều kiện
      showSnackBar(context,
          'Total amount does not meet the minimum requirement for the coupon.');
    }
  }

  void _updateTotalAmount(int newAmount) {
    print(_salelAmount);
    setState(() {
      _totalAmount = newAmount + 15000;
    });
  }

  Future<void> convertTotalAmountToUSD() async {
    final fx = Forex();
    double exchangeRate = await fx.getCurrencyConverted(
        sourceCurrency: 'VND',
        destinationCurrency: 'USD',
        sourceAmount: _totalAmount.toDouble());
    print(exchangeRate);
    setState(() {
      _totalAmountUSD = exchangeRate.toInt(); // Sửa đổi ở đây
    });
    print(_totalAmountUSD);
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
                      totalAmount: _totalAmount.toDouble(),
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
                      totalAmount: _totalAmount,
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
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                  child: Text('Xác nhận'),
                  onPressed: () async {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    await convertTotalAmountToUSD();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                            "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                        secretKey:
                            "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                        returnURL: "https://samplesite.com/return",
                        cancelURL: "https://samplesite.com/cancel",
                        transactions: [
                          {
                            "amount": {
                              "total": _totalAmountUSD,
                              "currency": "USD",
                            },
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          print("onSuccess: $params");
                          // Gọi hàm createneworder từ lớp CheckOutServices
                          http.Response res = await http.post(
                            Uri.parse(
                                '$url/api/v2/auth/create-order'), // Điều chỉnh đường dẫn API tại đây
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                              'x-auth-token': userProvider.user
                                  .token, // Giả sử token được lưu trong userProvider
                            },
                            body: jsonEncode({
                              'cart': _cartItems,
                              'shippingAddress': userProvider.selectedAddress,
                              'totalPrice': _totalAmount,
                              'paymentInfo': {'type': "Cash On PayPal"},
                            }),
                          );
                          Navigator.of(dialogContext).pop();
                          TLoaders.succesSnackbar(
                            title: 'Đặt hàng thành công',
                            message: 'Đơn hàng đã được lên và chờ duyệt.',
                          );
                        },
                        onError: (error) {
                          TLoaders.errorSnackbar(
                            title: 'Đặt hàng không thành công',
                            message: error,
                          );
                        },
                        onCancel: (params) {
                          print('cancelled: $params');
                        },
                      ),
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
