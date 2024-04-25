import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/tsinglepayment.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  // Thêm biến này
  const PaymentMethodScreen({
    super.key,
  });
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    // Danh sách các phương thức thanh toán
    final List<Map<String, dynamic>> paymentMethods = [
      {'name': 'COD', 'icon': Icons.money},
      {'name': 'Visa', 'icon': Icons.credit_card},
      {'name': 'PayPal', 'icon': Icons.payment},
    ];
    final Map<int, String> iconMap = {
      0xe900: 'money', // Ví dụ: mã codepoint của Icons.money
      0xe901: 'credit_card',
      // Thêm các mã codepoint và tên biểu tượng khác tương ứng ở đây
    };
    void _handlePaymentMethodSelection(
        BuildContext context, String paymentMethod, int iconCodePoint) {
      // Gọi hàm setSelectedPaymentMethod từ UserProvider
      Provider.of<UserProvider>(context, listen: false)
          .setSelectedPaymentMethod({
        'paymentMethod': paymentMethod,
        'iconCodePoint': iconCodePoint, // Lưu trữ mã codepoint
      });

      // // Quay lại màn hình trước đó với dữ liệu được chọn
      // Navigator.pop(context);
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Phương thức thanh toán',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: paymentMethods.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _handlePaymentMethodSelection(
                          context,
                          paymentMethods[index]['name'],
                          paymentMethods[index]['icon']
                              .codePoint); // Truyền mã codepoint);
                    },
                    child: TSinglePayment(
                      namePaymentMethod: paymentMethods[index]['name'],
                      paymentMethodIcon: paymentMethods[index]['icon'],
                      isSelected: paymentMethods[index]['name'] ==
                          Provider.of<UserProvider>(context)
                                  .selectedPaymentMethod?[
                              'paymentMethod'], // Cập nhật trạng thái isSelected
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
