import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';

class AlertMessage extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;
  final String alertImage;
  final Color buttonColor;
  AlertMessage({
    Key? key,
    required this.title,
    required this.message,
    required this.onTap,
    this.alertImage = "assets/images/dialog_success_image.png",
    this.buttonColor = primaryAppColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: greyScale850,
        surfaceTintColor: greyScale850,
        icon: Image.asset(
          alertImage,
          height: 100,
          width: 100,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
          ),
        ),
        actions: <Widget>[
          CustomButton(
            buttonText: "Okay",
            onTap: onTap,
            buttonColor: buttonColor,
            buttonTextColor: whiteColor,
          )
        ],
      ),
    );
  }
}
