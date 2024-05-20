import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/features/personalization/controllers/address_controller.dart';
import 'package:app_mobi_pharmacy/util/constans/province.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController cityController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();
    final TextEditingController address1Controller = TextEditingController();
    final TextEditingController address2Controller = TextEditingController();
    String? selectedCity; // Thêm biến selectedCity
    final List<String> addressTypes = [
      'Default',
      'Địa chỉ nhà',
      'Địa chỉ cơ quan'
    ];
    String? selectedAddressType;
    void _addAddress() {
      if (_formKey.currentState!.validate()) {
        // Lấy dữ liệu từ các trường nhập liệu
        String country = "Việt nam";
        String city = selectedCity.toString();
        String zipCode = zipCodeController.text;
        String address1 = address1Controller.text;
        String address2 = address2Controller.text;

        // Tạo một map với dữ liệu địa chỉ
        Map<String, dynamic> addressData = {
          'country': "Việt nam",
          'city': city,
          'zipCode': zipCode,
          'address1': address1,
          'address2': address2,
          'addressType': selectedAddressType,
        };

        // Gọi API để thêm địa chỉ mới
        AddressServices().addAddress(
          context: context,
          addressData: addressData,
          onSuccessfulUpdate: () {
            // Clear các trường nhập liệu sau khi thêm địa chỉ thành công

            cityController.clear();
            zipCodeController.clear();
            address1Controller.clear();
            address2Controller.clear();
            selectedAddressType = null; // Hoặc giá trị mặc định nếu bạn có
          },
        );

        // Hiển thị thông báo hoặc cập nhật UI tùy thuộc vào kết quả của API
        // Ví dụ: Nếu API trả về thành công, hiển thị thông báo và quay lại màn hình trước
        // Nếu API trả về lỗi, hiển thị thông báo lỗi
      } else {
        // Hiển thị thông báo lỗi nếu form không hợp lệ
        print('Please fill in all fields correctly.');
      }
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Add New Addresses',
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
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Quốc gia'),
                  initialValue: 'Việt Nam', readOnly: true, // Gắn giá trị mặc
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  onChanged: (newValue) {
                    // Xử lý sự kiện khi người dùng thay đổi giá trị
                    selectedCity = newValue;
                  },
                  items: ProvinceList.provinces
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Chọn thành phố',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: zipCodeController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.code), labelText: 'Zip Code'),
                ),
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
                    onPressed: _addAddress,
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
