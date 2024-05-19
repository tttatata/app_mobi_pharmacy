// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/address.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/paymentmethod.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class TBillingPaymentMethodSection extends StatefulWidget {
  const TBillingPaymentMethodSection({
    Key? key,
  }) : super(key: key);

  @override
  _TBillingPaymentMethodSectionState createState() =>
      _TBillingPaymentMethodSectionState();
}

class _TBillingPaymentMethodSectionState
    extends State<TBillingPaymentMethodSection> {
  void initState() {
    super.initState();
    // Gọi hàm loadSelectedAddress khi initState được gọi
    context.read<UserProvider>().loadSelectedPaymentMethod();
  }

  void _handleChangeButtonPressed(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodScreen(), // Truyền lựa chọn hiện tại
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final paymentMethodselect =
        Provider.of<UserProvider>(context).selectedPaymentMethod;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSetionHeading(
          title: 'Phương thức thanh toán ',
          buttonTitle: 'Change',
          onPressed: () => _handleChangeButtonPressed(context),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Column(
          children: [
            paymentMethodselect != null
                ? Column(
                    children: [
                      Row(
                        children: [
                          // IconData(paymentMethodselect?['iconCodePoint'],
                          //     fontFamily: 'MaterialIcons'),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            paymentMethodselect?['paymentMethod'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                    ],
                  )
                : Text('Bạn chưa chọn phương thức thanh toán!!')
          ],
        ),
      ],
    );
  }
}
