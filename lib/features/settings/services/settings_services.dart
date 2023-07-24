import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_mobile_web_admin/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_web_admin/core/error/error_handler.dart';
import 'package:pay_mobile_web_admin/core/utils/custom_dialogs.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SettingsServices {
  void createAdmin({
    required BuildContext context,
    required String fullname,
    required String username,
    required String email,
    required String password,
    required String type,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/admin/createAdmin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": userToken,
            },
            body: jsonEncode({
              'fullname': fullname,
              'username': username,
              'email': email,
              'password': password,
              'type': type,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            print(res.statusCode);
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)["message"],
                onTap: () {
                  popNav(context);
                });
          });
    } on Error catch (e) {
      print('Create Admin Error: $e');
    }
  }

  Future checkAvailableUsername({
    required BuildContext context,
    required String username,
    required VoidCallback onSuccess,
  }) async {
    String errorText = '';
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/getUsername/$username'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            // 'x-auth-token': userToken,
          }).timeout(const Duration(seconds: 25));

      switch (res.statusCode) {
        case 200:
          onSuccess();
          break;
        case 400:
          errorText = jsonDecode(res.body)['message'];
          break;
        case 500:
          print(jsonDecode(res.body));
      }
    } on Error catch (e) {
      print('Check Avaliable Username Error: $e');
    }
    return errorText;
  }

  void deleteAdmin({
    required BuildContext context,
    required String username,
    required String authorizationPin,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .delete(
            Uri.parse('$uri/admin/deleteAdmin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": userToken,
            },
            body: jsonEncode({
              'username': username,
              'authorizationPin': authorizationPin,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)["message"],
                onTap: () {
                  popNav(context);
                });
          });
    } on Error catch (e) {
      print('Delete Admin Error: $e');
    }
  }

  void changeAdminAuthorizationPin({
    required BuildContext context,
    required String oldAdminAuthPin,
    required String newAdminAuthPin,
    required String admin,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .delete(
            Uri.parse('$uri/admin/deleteUser'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": userToken,
            },
            body: jsonEncode({
              'username': oldAdminAuthPin,
              'authorizationPin': newAdminAuthPin,
              "admin": admin,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)["message"],
                onTap: () {
                  popNav(context);
                });
          });
    } on Error catch (e) {
      print('Delete Admin or User Pin Error: $e');
    }
  }
}
