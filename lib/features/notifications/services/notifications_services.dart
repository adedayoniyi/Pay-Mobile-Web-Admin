import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_mobile_web_admin/core/error/error_handler.dart';
import 'package:pay_mobile_web_admin/core/utils/custom_dialogs.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:provider/provider.dart';

class NotificationServices {
  void sendPushNotificationToAllDevices({
    required BuildContext context,
    required String title,
    required String body,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http.post(
        Uri.parse("$uri/admin/sendPushNotifications"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'x-auth-token': userToken,
        },
        body: jsonEncode(
          {
            "title": title,
            "body": body,
          },
        ),
      );
      Navigator.pop(context);
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)['message'],
                onTap: () {
                  Navigator.pop(context);
                });
          });
    } catch (e) {
      print("Error");
    }
  }
}
