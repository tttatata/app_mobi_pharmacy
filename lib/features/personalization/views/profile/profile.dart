import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/dialog/edit_phonenumber_dialog.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/personalization/controllers/profile_controller.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/widgets/change_password_user_dialog.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/widgets/edit_user_information_dialog.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/widgets/profile_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController _userController =
      UserController(); // Tạo instance của UserController

  void _onUpdateSuccess() {
    // Hành động sau khi cập nhật thành công
    Navigator.pop(context); // Đóng dialog hoặc trở về màn hình trước
  }

  void _updateUserInformation(Map<String, dynamic> userData) {
    // Gọi hàm updateUser từ UserController
    _userController.updateUser(
      context: context,

      userData: userData, // Dữ liệu cập nhật cho người dùng
      onSuccessfulUpdate:
          _onUpdateSuccess, // Callback sau khi cập nhật thành công
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    print(user.name);
    String message = user.phoneNumber == 0
        ? 'Bạn chưa nhập số điện thoại'
        : user.phoneNumber.toString();
    void _updatePhoneNumber(int newPhoneNumber) {
      setState(() {
        user.phoneNumber = newPhoneNumber;
      });
    }

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(
                      image: user.avatar!.url.isEmpty
                          ? TImages.user
                          : user.avatar!.url.toString(),
                      isNetworkImage: user.avatar!.url.isEmpty ? false : true,
                      width: 120,
                      height: 120,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              //details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSetionHeading(
                title: 'Profile information',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProfileMenu(
                title: 'Tên',
                value: user.name,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditUserInformationDialog(
                        title: 'tên',
                        currentValue: user.name,
                        onInformationSaved: (String newName) {
                          // Cập nhật tên của người dùng
                          _updateUserInformation({'name': newName});
                        },
                      );
                    },
                  );
                },
              ),

              ProfileMenu(
                icon: Iconsax.copy,
                title: 'User ID',
                value: user.id,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Email',
                value: user.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: user.phoneNumber.toString(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditPhoneNumberDialog(
                        initialPhoneNumber: user.phoneNumber,
                        onPhoneNumberSaved: (int newPhoneNumber) {
                          // Cập nhật số điện thoại của người dùng
                          _updateUserInformation(
                              {'phoneNumber': newPhoneNumber});
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ChangePasswordDialog(
                          onPasswordChanged: (String currentPassword,
                              String newPassword,
                              String confirmNewPassword) async {
                            // Kiểm tra xem mật khẩu hiện tại có đúng không
                            // Nếu đúng, gọi API hoặc phương thức để cập nhật mật khẩu của người dùng
                            // Nếu không, hiển thị thông báo lỗi
                            if (await _userController.validateCurrentPassword(
                                context, currentPassword)) {
                              if (newPassword == confirmNewPassword) {
                                _userController.updateUser(
                                  context: context,
                                  userData: {
                                    'password': newPassword,
                                  }, // Dữ liệu cập nhật mật khẩu
                                  onSuccessfulUpdate:
                                      _onUpdateSuccess, // Callback sau khi cập nhật thành công
                                );
                              } else {
                                // Hiển thị thông báo lỗi mật khẩu mới không khớp
                              }
                            } else {
                              // Hiển thị thông báo lỗi mật khẩu hiện tại không đúng
                            }
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Đổi mật khẩu đăng nhập', // Update the text here
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
