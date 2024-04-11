import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 4,
    this.textAlign = TextAlign.left,
  });
  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? TextStyle(fontSize: 9, backgroundColor: Colors.black12)
          : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.clip,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
