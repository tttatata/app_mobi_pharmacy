import 'dart:ffi';

import 'package:app_mobi_pharmacy/common/snackbar';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Coupon.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCouponCode extends StatefulWidget {
  final Function(Coupon) onCouponApplied;

  const TCouponCode({
    super.key,
    required this.onCouponApplied,
  });

  @override
  _TCouponCodeState createState() => _TCouponCodeState();
}

class _TCouponCodeState extends State<TCouponCode> {
  late final TextEditingController couponController;

  @override
  void initState() {
    super.initState();
    couponController = TextEditingController();
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  Future<void> applyCoupon(BuildContext context, String couponCode) async {
    final checkOutServices = CheckOutServices();
    Coupon? coupon = await checkOutServices.fetchCoupon(
      context: context,
      couponname: couponCode,
    );
    if (coupon != null) {
      showSnackBar(context, 'Coupon applied successfully!');
      widget.onCouponApplied(coupon); // Gọi callback với đối tượng Coupon
    } else {
      showSnackBar(context, 'Failed to apply coupon.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
          top: TSizes.sm, bottom: TSizes.sm, right: TSizes.sm, left: TSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: couponController,
              decoration: InputDecoration(
                hintText: 'Have a promo code? Enter Here',
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {
                // Sử dụng hàm applyCoupon mới
                applyCoupon(context, couponController.text);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? TColors.white.withOpacity(0.5)
                    : TColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
