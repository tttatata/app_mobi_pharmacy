import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/curved_edges/curved_edgges_widget.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TCurvedEdgetWidget(
      child: Container(
        color: TColors.primary,
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
