import 'package:flutter/material.dart';

class EditPhoneNumberDialog extends StatefulWidget {
  final int initialPhoneNumber;
  final Function(int) onPhoneNumberSaved;

  const EditPhoneNumberDialog({
    Key? key,
    required this.initialPhoneNumber,
    required this.onPhoneNumberSaved,
  }) : super(key: key);

  @override
  _EditPhoneNumberDialogState createState() => _EditPhoneNumberDialogState();
}

class _EditPhoneNumberDialogState extends State<EditPhoneNumberDialog> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController =
        TextEditingController(text: widget.initialPhoneNumber.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cập nhật số điện thoại'),
      content: TextField(
        controller: _phoneController,
        decoration: InputDecoration(
          hintText: 'Nhập số điện thoại mới của bạn',
        ),
        keyboardType: TextInputType.phone,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Hủy bỏ'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Lưu'),
          onPressed: () {
            final newPhoneNumber = int.tryParse(_phoneController.text);
            if (newPhoneNumber != null) {
              widget.onPhoneNumberSaved(newPhoneNumber);
              Navigator.of(context).pop(); // Đóng cửa sổ dialog sau khi lưu
            } else {
              // Hiển thị thông báo lỗi nếu số điện thoại không hợp lệ
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Vui lòng nhập một số điện thoại hợp lệ.'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
