import 'dart:convert';

import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
          totalAmount: totalAmount,
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
    required int totalAmount,
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

      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2));
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
}
