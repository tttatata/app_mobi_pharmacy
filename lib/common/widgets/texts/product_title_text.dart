import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 6,
    this.textAlign = TextAlign.left,
  });
  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Text(
        title,
        style: smallSize
            ? TextStyle(fontSize: 12)
            : Theme.of(context).textTheme.titleSmall,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
