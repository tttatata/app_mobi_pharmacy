import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:flutter/material.dart';

class TProductSoldText extends StatelessWidget {
  const TProductSoldText({
    super.key,
    required this.sold,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });
  final String sold;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Đã bán',
          overflow: TextOverflow.ellipsis,
          style: isLarge
              ? Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 7, // Thay đổi kích thước văn bản ở đây
                    decoration: lineThrough ? TextDecoration.lineThrough : null,
                  )
              : Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 12, // Thay đổi kích thước văn bản ở đây
                    decoration: lineThrough ? TextDecoration.lineThrough : null,
                  ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems / 5,
        ),
        Text(
          sold,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: isLarge
              ? Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 7, // Thay đổi kích thước văn bản ở đây
                    decoration: lineThrough ? TextDecoration.lineThrough : null,
                  )
              : Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 12, // Thay đổi kích thước văn bản ở đây
                    decoration: lineThrough ? TextDecoration.lineThrough : null,
                  ),
        ),
      ],
    );
  }
}
