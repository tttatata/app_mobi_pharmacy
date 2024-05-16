import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/features/personalization/controllers/address_controller.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/widgets/addressform.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditAddressScreen extends StatefulWidget {
  final Map<String, dynamic> currentAddress;
  const EditAddressScreen({Key? key, required this.currentAddress})
      : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController zipCodeController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  String? selectedAddressType;
  // Định nghĩa addressTypes ở đây
  final List<String> addressTypes = [
    'Default',
    'Địa chỉ nhà',
    'Địa chỉ cơ quan'
  ];
  @override
  void initState() {
    super.initState();
    // Khởi tạo các TextEditingController với giá trị ban đầu từ widget.currentAddress
    countryController =
        TextEditingController(text: widget.currentAddress['country'] ?? '');
    cityController =
        TextEditingController(text: widget.currentAddress['city'] ?? '');
    zipCodeController = TextEditingController(
        text: widget.currentAddress['zipCode'].toString() ?? '');
    address1Controller =
        TextEditingController(text: widget.currentAddress['address1'] ?? '');
    address2Controller =
        TextEditingController(text: widget.currentAddress['address2'] ?? '');
    selectedAddressType = widget.currentAddress['addressType'];
  }

  void _updateAddress() {
    if (_formKey.currentState!.validate()) {
      // Lấy dữ liệu từ các trường nhập liệu
      Map<String, dynamic> addressData = {
        'country': countryController.text,
        'city': cityController.text,
        'zipCode': zipCodeController.text,
        'address1': address1Controller.text,
        'address2': address2Controller.text,
        'addressType': selectedAddressType,
      };

      // Gọi phương thức updateAddress từ AddressServices
      AddressServices().updateAddress(
        context: context,
        addressId: widget.currentAddress['_id']
            .toString(), // Đảm bảo rằng 'id' được truyền đúng
        addressData: addressData,
        onSuccessfulUpdate: () {
          // Hành động sau khi cập nhật thành công
          Navigator.pop(context);
          // Không cần gọi setState ở đây nếu bạn chỉ đang thoát khỏi màn hình
        },
      );
    } else {
      // Hiển thị thông báo lỗi nếu form không hợp lệ
      print('Please fill in all fields correctly.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Chỉnh sửa địa chỉ',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(widget.currentAddress['_id']),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Quốc gia'),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'Thành phố'),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: zipCodeController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: 'Zip Code'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: address1Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.buildings4),
                      labelText: 'Địa chỉ 1'),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: address2Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.buildings4),
                      labelText: 'Địa chỉ 2'),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.location),
                    labelText: 'Loại địa chỉ',
                  ),
                  value: selectedAddressType,
                  onChanged: (String? newValue) {
                    // Cập nhật giá trị được chọn
                    selectedAddressType = newValue;
                  },
                  items: addressTypes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateAddress,
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
