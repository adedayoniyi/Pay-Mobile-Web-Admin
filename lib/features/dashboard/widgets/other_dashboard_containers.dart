import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';

class OtherDashBoardContainers extends StatelessWidget {
  const OtherDashBoardContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          color: greyScale850,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
