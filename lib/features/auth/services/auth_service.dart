import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_web_admin/core/error/error_handler.dart';
import 'package:pay_mobile_web_admin/core/utils/custom_dialogs.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/widgets/home.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void loginInAdmin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/admin/loginAdmin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            namedNavRemoveUntil(context, Home.route);
          });
    } on Error catch (e) {
      print('Login Error: $e');
    }
  }

  Future obtainTokenAndUserData(
    BuildContext context,
  ) async {
    try {
      //showDialogLoader(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('x-auth-token');

      if (authToken == null) {
        prefs.setString('x-auth-token', '');
      }

      var returnedTokenResponse = await http.post(Uri.parse('$uri/checkToken'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': authToken!
          });
      //the response will supply us with true or false according to the tokenIsValid api
      var response = jsonDecode(returnedTokenResponse.body);

      if (response == true) {
        //get user data

        http.Response returnedUserResponse =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': authToken,
        });

        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        );
        userProvider.setUser(returnedUserResponse.body);
        //Navigator.of(context, rootNavigator: true).pop('dialog');
      }
      return response;
    } catch (e) {
      print(e);
    }
  }
}
