// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/address.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class TBillingAddressSection extends StatefulWidget {
  const TBillingAddressSection({super.key});

  @override
  _TBillingAddressSectionState createState() => _TBillingAddressSectionState();
}

class _TBillingAddressSectionState extends State<TBillingAddressSection> {
  void _handleChangeButtonPressed(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserAddressScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    // Gọi hàm loadSelectedAddress khi initState được gọi
    context.read<UserProvider>().loadSelectedAddress();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final addressselect = Provider.of<UserProvider>(context).selectedAddress;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSetionHeading(
          title: 'Địa chỉ giao hàng',
          buttonTitle: 'Change',
          onPressed: () => _handleChangeButtonPressed(context),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Column(
          children: [
            addressselect != null
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text('Loại địa chỉ',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            addressselect!['addressType']
                                .toString(), // Sử dụng toán tử null-aware
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.house,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Expanded(
                            child: addressselect != null
                                ? Row(
                                    children: [
                                      Text(addressselect?['address1'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text(',',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text(addressselect['city'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ],
                                  )
                                : Text(''),
                          ),
                        ],
                      ),
                    ],
                  )
                : Text('bạn chưa chọn địa chỉ giao hàng!!')
          ],
        ),
      ],
    );
  }
}
