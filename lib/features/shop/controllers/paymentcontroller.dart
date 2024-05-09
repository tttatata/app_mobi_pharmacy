import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:app_mobi_pharmacy/main.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
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
  /////
  ///

  // ... các phương thức và biến đã có ...

  // Future<void> handlePayPalPayment({
  //   required BuildContext context,
  //   required List<Map<String, dynamic>> cartItems,
  //   required int totalAmount,
  //   // Thêm các tham số khác nếu cần
  // }) async {
  //   // Tạo một giao dịch PayPal với thông tin cần thiết
  //   navigatorKey.currentState?.push(
  //     MaterialPageRoute(
  //       builder: (BuildContext context) => UsePaypal(
  //           sandboxMode: true,
  //           clientId:
  //               "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
  //           secretKey:
  //               "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
  //           returnURL: "https://samplesite.com/return",
  //           cancelURL: "https://samplesite.com/cancel",
  //           transactions: const [
  //             {
  //               "amount": {
  //                 "total": "10.12",
  //                 "currency": "USD",
  //                 "details": {
  //                   "subtotal": "10.12",
  //                   "shipping": "0",
  //                   "shipping_discount": "0"
  //                 }
  //               },
  //               "description": "The payment transaction description.",
  //               "item_list": {
  //                 "items": [
  //                   {
  //                     "name": "A demo product",
  //                     "quantity": 1,
  //                     "price": "10.12",
  //                     "currency": "USD"
  //                   }
  //                 ],
  //                 "shipping_address": {
  //                   "recipient_name": "Jane Foster",
  //                   "line1": "Travis County",
  //                   "line2": "",
  //                   "city": "Austin",
  //                   "country_code": "US",
  //                   "postal_code": "73301",
  //                   "phone": "+00000000",
  //                   "state": "Texas"
  //                 }
  //               }
  //             }
  //           ],
  //           note: "Contact us for any questions on your order.",
  //           onSuccess: (Map params) async {
  //             navigatorKey.currentState?.pop();
  //             // Đóng dialog hiện tại nếu có
  //             navigatorKey.currentState?.push(
  //               MaterialPageRoute(
  //                 builder: (context) => SuccesScreen(
  //                   image: TImages.successfulPaymentIcon,
  //                   title: 'Payment Success!',
  //                   subtitle: 'Your item will be shipped soon!',
  //                   onPressed: () {
  //                     // Sử dụng Get.offAll để chuyển hướng người dùng và xóa tất cả các màn hình trước đó
  //                     Get.offAll(() => NavigationMenu());
  //                   },
  //                 ),
  //               ),
  //             );
  //           },
  //           onError: (error) {
  //             print("onError: $error");
  //           },
  //           onCancel: (params) {
  //             print('cancelled: $params');
  //           }),
  //     ),
  //   );
  //   // ... các phương thức khác ...
  // }
}
