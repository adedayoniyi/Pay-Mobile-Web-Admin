import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/assets.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset(
            logo,
            height: 35,
          ),
        ),
        const Center(
          child: SizedBox(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
