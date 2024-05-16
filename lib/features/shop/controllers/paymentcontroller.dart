import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:app_mobi_pharmacy/main.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:currency_converter/currency.dart';
import 'package:provider/provider.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  final CheckOutServices _checkOutServices = CheckOutServices();
  Future<void> makePayment({
    required String currency,
    required List<Map<String, dynamic>> cartItems,
    required int totalAmount,
    required String payment,
    required BuildContext context,
  }) async {
    try {
      paymentIntentData =
          await createPaymentIntent(totalAmount.toString(), currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'VND',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        // Truyền các biến cần thiết vào hàm displayPaymentSheet
        displayPaymentSheet(
          context: context,
          cartItems: cartItems,
          totalAmount: totalAmount.toDouble(),
          payment: payment,
        );
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet({
    required BuildContext context,
    required List<Map<String, dynamic>> cartItems,
    required double totalAmount,
    required String payment,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Tạo một thể hiện của CheckOutServices
      CheckOutServices checkOutServices = CheckOutServices();

      // Gọi hàm createneworder từ lớp CheckOutServices
      checkOutServices.createneworder(
        context: context,
        cartItems: cartItems,
        totalAmount: totalAmount,
        payment: payment,
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51P8SPHBfBX9EjqptbXo9eS6SbvCBSNjfTl0BoQH2tQSQUZ9g5sTKRje1CrgAQfGrS1VwfOe6esiH4ICjfrjPwJ0q000zrTN2WP',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount));
    return a.toString();
  }

  Future<void> handlePayPalPayment({
    required BuildContext context,
    required double totalAmountUSD, // Đã chuyển đổi sang USD
    required String payment,
    required double totalAmount,
    required List<Map<String, dynamic>> cartItems,
    // Thêm các tham số khác nếu cần
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
              "total": totalAmountUSD, // Sử dụng giá trị đã chuyển đổi
              "currency": "USD",
            },
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
          // Tạo một thể hiện của CheckOutServices

          print("onSuccess: $params.success");
          // Gọi hàm createneworder từ lớp CheckOutServices
          http.Response res = await http.post(
            Uri.parse(
                '$url/api/v2/auth/create-order'), // Điều chỉnh đường dẫn API tại đây
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': userProvider
                  .user.token, // Giả sử token được lưu trong userProvider
            },

            body: jsonEncode({
              'cart': cartItems,
              'shippingAddress': userProvider.selectedAddress,
              'totalPrice': totalAmount,
              'paymentInfo': {'type': payment},
            }),
          );

          // Chuyển hướng người dùng đến màn hình thành công
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
  }
}
