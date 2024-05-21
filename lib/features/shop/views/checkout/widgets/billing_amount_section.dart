// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';

class TBillingAmountSection extends StatelessWidget {
  final double salelAmount; // Thêm thuộc tính này
  const TBillingAmountSection({
    Key? key,
    required this.onTotalAmountChanged,
    required this.salelAmount,
  }) : super(key: key);
  final Function(double) onTotalAmountChanged;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0.0;
    user.cart?.forEach((e) {
      final price = e['product']['sellPrice'];
      if (price != null) {
        sum += e['quantity'] * (price as int).toDouble(); // Convert to double
      }
    });
    // Gọi callback khi có tổng tiền
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onTotalAmountChanged(sum);
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sản phẩm',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              TFormatter.formatCurrency(sum),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chi phí giao hàng',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              TFormatter.formatCurrency(15000),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Giá giảm',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.red),
            ),
            Text(
              TFormatter.formatCurrency(salelAmount),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng tiền',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              TFormatter.formatCurrency(sum.toDouble() + 15000 - salelAmount),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
