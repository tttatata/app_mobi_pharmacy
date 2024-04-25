import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddressForm extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSubmit;

  const AddressForm({
    Key? key,
    this.initialData,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController zipCodeController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  String? selectedAddressType;
  final List<String> addressTypes = [
    'Default',
    'Địa chỉ nhà',
    'Địa chỉ cơ quan'
  ];

  @override
  void initState() {
    super.initState();
    countryController =
        TextEditingController(text: widget.initialData?['country']);
    cityController = TextEditingController(text: widget.initialData?['city']);
    zipCodeController =
        TextEditingController(text: widget.initialData?['zipCode']);
    address1Controller =
        TextEditingController(text: widget.initialData?['address1']);
    address2Controller =
        TextEditingController(text: widget.initialData?['address2']);
    selectedAddressType = widget.initialData?['addressType'];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                      prefixIcon: Icon(Iconsax.code), labelText: 'Zip Code'),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: address1Controller,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.buildings4), labelText: 'Địa chỉ 1'),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: address2Controller,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.buildings4), labelText: 'Địa chỉ 2'),
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
            items: addressTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: TSizes.defaultSpace),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit({
                  'country': countryController.text,
                  'city': cityController.text,
                  'zipCode': zipCodeController.text,
                  'address1': address1Controller.text,
                  'address2': address2Controller.text,
                  'addressType': selectedAddressType,
                });
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
