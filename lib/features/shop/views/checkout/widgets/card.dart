import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/coupon_widgets.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/cart/widgents/cart_items.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_paymentmethod.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_user.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/paymentmethod.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentCardScreen extends StatefulWidget {
  const PaymentCardScreen({super.key});

  @override
  _PaymentCardScreenState createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Thanh toán với thẻ tín dụng',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Card Form'),
              const SizedBox(
                height: 20,
              ),
              CardField(
                onCardChanged: (card) {
                  print(card);
                },
              )
            ],
          ),
        ));
  }
}
