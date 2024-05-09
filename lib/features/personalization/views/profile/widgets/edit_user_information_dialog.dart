import 'package:flutter/material.dart';

class EditUserInformationDialog extends StatefulWidget {
  final String title; // Tiêu đề của thông tin cần cập nhật
  final String currentValue; // Giá trị hiện tại của thông tin
  final Function(String) onInformationSaved; // Callback khi thông tin được lưu

  const EditUserInformationDialog({
    Key? key,
    required this.title,
    required this.currentValue,
    required this.onInformationSaved,
  }) : super(key: key);

  @override
  _EditUserInformationDialogState createState() =>
      _EditUserInformationDialogState();
}

class _EditUserInformationDialogState extends State<EditUserInformationDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cập nhật ${widget.title}'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Nhập ${widget.title} mới',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Hủy'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Lưu'),
          onPressed: () {
            widget.onInformationSaved(_controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
