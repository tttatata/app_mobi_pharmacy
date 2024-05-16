// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_mobi_pharmacy/features/personalization/controllers/address_controller.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/edit_addressform.dart.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/widgets/addressform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    Key? key,
    required this.selectedAddress,
    required this.address,
  }) : super(key: key);
  final bool selectedAddress;
  final dynamic address;
  void confirmDeleteAddress(BuildContext context, dynamic address) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Xác nhận xóa địa chỉ'),
          content: Text('Bạn có chắc chắn muốn xóa địa chỉ này không?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () {
                // Gọi hàm deleteAddress từ AddressServices
                AddressServices().deleteAddress(
                  context: context,
                  addressId: address[
                      '_id'], // Giả sử 'id' là trường chứa ID của địa chỉ
                  onSuccessfulDelete: () {
                    // Hành động sau khi xóa thành công
                    Navigator.of(dialogContext).pop(); // Đóng hộp thoại
                    // Cập nhật UI hoặc hiển thị thông báo tại đây nếu cần
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: selectedAddress
          ? Color.fromARGB(255, 0, 132, 255).withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? TColors.darkGrey
              : Color.fromARGB(255, 4, 1, 160),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress
                    ? dark
                        ? TColors.light
                        : TColors.dark
                    : null),
          ),
          Positioned(
            right: 5,
            bottom: 10,
            child: Row(
              children: [
                // Trong TSingleAddress
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditAddressScreen(currentAddress: address),
                      ),
                    );
                  },
                  child: Icon(Iconsax.edit,
                      color: dark
                          ? TColors.light
                          : Color.fromARGB(255, 8, 219, 1)),
                ),

                const SizedBox(
                  width: TSizes.sm / 2,
                ),
                GestureDetector(
                  onTap: () {
                    confirmDeleteAddress(context, address);
                  },
                  child: Icon(Iconsax.trash,
                      color: dark
                          ? TColors.light
                          : Color.fromARGB(255, 255, 40, 40)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address['addressType'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: TSizes.sm / 2,
              ),
              Row(
                children: [
                  Text(
                    'Địa chỉ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: TSizes.sm / 2,
                  ),
                  Text(
                    address['address1'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ',',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    address['city'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ',',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    address['country'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.sm / 2,
              ),
              Row(
                children: [
                  Text('zipCode',
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(
                    width: TSizes.sm / 2,
                  ),
                  Text(
                    address['zipCode'].toString(),
                    softWrap: true,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
