import 'dart:io';

import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/features/authentication/controllers/signup/signup_controller.dart';

import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:app_mobi_pharmacy/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

enum Signup {
  signup,
}

class TSignUpForm extends StatefulWidget {
  const TSignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<TSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final Signup _signup = Signup.signup;
  final hidepassword = true.obs;
  final privatePolicy = true.obs;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SignUpController _signUpController = SignUpController();
  File? images;
  bool remember = false;
  String? currentImagePath;
  final List<String?> errors = [];

  void signUpUser() {
    _signUpController.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      images: images,
    );
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
      if (images != null) {
        currentImagePath = images!.path; // Lưu đường dẫn hình ảnh
        // Kiểm tra đường dẫn hình ảnh sau khi chọn
        checkImagePath(currentImagePath!);
      }
    });

    print('images:$images');
  }

  void checkImagePath(String imagePath) {
    final file = File(imagePath);
    print('Kiểm tra đường dẫn hình ảnh: $imagePath');
    if (file.existsSync()) {
      print('Hình ảnh tồn tại.');
    } else {
      print(
          'Hình ảnh không tồn tại. Kiểm tra lại đường dẫn hoặc quyền truy cập.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                images != null
                    ? // Kiểm tra nếu có hình ảnh đã chọn
                    Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: Image.file(
                              images!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Điều chỉnh khoảng cách của icon so với góc
                            child: InkWell(
                              onTap:
                                  selectImages, // Gọi hàm selectImages khi nút được nhấn
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // Màu nền cho nút icon
                                  shape: BoxShape
                                      .circle, // Tạo hình tròn cho nút icon
                                ),
                                child: Icon(
                                  Icons.camera_alt, // Sử dụng icon camera
                                  size: 24.0, // Kích thước của icon
                                  color: Colors.blue, // Màu sắc của icon
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          TCircularImage(
                            image: TImages
                                .user, // Sử dụng hình ảnh đã chọn hoặc hình ảnh mặc định
                            isNetworkImage:
                                false, // Đặt là false vì hình ảnh không phải từ mạng
                            width: 100,
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Điều chỉnh khoảng cách của icon so với góc
                            child: InkWell(
                              onTap:
                                  selectImages, // Gọi hàm selectImages khi nút được nhấn
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // Màu nền cho nút icon
                                  shape: BoxShape
                                      .circle, // Tạo hình tròn cho nút icon
                                ),
                                child: Icon(
                                  Icons.camera_alt, // Sử dụng icon camera
                                  size: 24.0, // Kích thước của icon
                                  color: Colors.blue, // Màu sắc của icon
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Username

          TextFormField(
            controller: _nameController,
            validator: (value) =>
                TValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Email
          TextFormField(
            controller: _emailController,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //password
          Obx(
            () => TextFormField(
              controller: _passwordController,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: hidepassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => hidepassword.value = !hidepassword.value,
                  icon: Icon(
                      hidepassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///tém&condition checkbox
          Row(
            children: [
              SizedBox(
                  width: 25,
                  height: 24,
                  child: Obx(() => Checkbox(
                      value: privatePolicy.value,
                      onChanged: (value) =>
                          privatePolicy.value = !privatePolicy.value))),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: TTexts.iAgreeTo,
                    style: Theme.of(context).textTheme.labelLarge),
                TextSpan(
                    text: ' ', style: Theme.of(context).textTheme.labelLarge),
                TextSpan(
                    text: TTexts.termsOfUse,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? TColors.white : TColors.primary,
                        )),
              ]))
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          ///sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signUpUser();
                }
              },
              child: const Text(TTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
