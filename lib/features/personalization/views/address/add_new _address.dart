import 'package:app_mobi_pharmacy/features/personalization/controllers/address_controller.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/widgets/addressform.dart';
import 'package:flutter/material.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: AddressForm(
        onSubmit: (Map<String, dynamic> formData) {
          // Chuyển đổi zipCode sang int
          int? zipCodeInt = int.tryParse(formData['zipCode']);
          if (zipCodeInt == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Zip code must be a number.')),
            );
            return;
          }

          // Cập nhật formData với zipCode dạng int
          formData['zipCode'] = zipCodeInt;

          // Gọi API để thêm địa chỉ mới
          AddressServices().addAddress(
            context: context,
            addressData: formData,
            onSuccessfulUpdate: () {
              // Cập nhật UI nếu cần
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
