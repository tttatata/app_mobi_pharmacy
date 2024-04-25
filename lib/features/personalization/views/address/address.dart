import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/addressform.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/widgets/addressform.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/widgets/single_address.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({super.key});

  @override
  _UserAddressScreenState createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            Container(
              child: user.addresses.length == 0
                  ? Text(
                      'Bạn không có địa chỉ giao hàng nào. \nVui lòng thêm địa chỉ để tiếp tục đặt hàng',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: user.addresses!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Khi người dùng chọn một địa chỉ, truyền nó trở lại
                              Provider.of<UserProvider>(context, listen: false)
                                  .setSelectedAddress(user.addresses[index]);
                            },
                            child: TSingleAddress(
                              selectedAddress:
                                  Provider.of<UserProvider>(context)
                                          .selectedAddress?['addressType'] ==
                                      user.addresses[index]['addressType'],
                              address: user.addresses[index],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
