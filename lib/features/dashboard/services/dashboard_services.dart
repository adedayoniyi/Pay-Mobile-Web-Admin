import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_mobile_web_admin/core/error/error_handler.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DashBoardServices {
  Future<int> getTotalTransactions({
    required BuildContext context,
  }) async {
    int totalNumberOfUserTransactions = 0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getTotalNumberOfTransactions"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfUserTransactions = jsonDecode(res.body);
          });
    }
    // on TimeoutException catch (e) {
    //   showTimeOutError(
    //     context: context,
    //   );
    // } on SocketException catch (e) {
    //   showNoInternetError(
    //     context: context,
    //   );
    // }
    on Error catch (e) {
      print('Get All User Transactions Error: $e');
    }
    return totalNumberOfUserTransactions;
  }

  Future<int> getTotalUserBalance({
    required BuildContext context,
  }) async {
    int totalNumberOfUserBalance = 0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getTotalUserBalance"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfUserBalance = jsonDecode(res.body);
          });
    }
    // on TimeoutException catch (e) {
    //   showTimeOutError(
    //     context: context,
    //   );
    // } on SocketException catch (e) {
    //   showNoInternetError(
    //     context: context,
    //   );
    // }
    on Error catch (e) {
      print('Get All User Balance Error: $e');
    }
    return totalNumberOfUserBalance;
  }

  Future<int> getTotalNumberOfUsers({
    required BuildContext context,
  }) async {
    int totalNumberOfUsers = 0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getTotalNumberOfAllUsers"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfUsers = jsonDecode(res.body);
          });
    }
    // on TimeoutException catch (e) {
    //   showTimeOutError(
    //     context: context,
    //   );
    // } on SocketException catch (e) {
    //   showNoInternetError(
    //     context: context,
    //   );
    // }
    on Error catch (e) {
      print('Get All User Balance Error: $e');
    }
    return totalNumberOfUsers;
  }

  Future<int> getTotalNumberOfWalletFundings({
    required BuildContext context,
  }) async {
    int totalNumberOfWalletFundings = 0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getNumberOfWalletFundings"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfWalletFundings = jsonDecode(res.body);
          });
    }
    // on TimeoutException catch (e) {
    //   showTimeOutError(
    //     context: context,
    //   );
    // } on SocketException catch (e) {
    //   showNoInternetError(
    //     context: context,
    //   );
    // }
    on Error catch (e) {
      print('Get wallet Fundings Error: $e');
    }
    return totalNumberOfWalletFundings;
  }

  Future<int> getTotalNumberOfCreditTransactions({
    required BuildContext context,
  }) async {
    int totalNumberOfCreditTransactions = 0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getNumberOfCreditTransactions"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfCreditTransactions = jsonDecode(res.body);
          });
    }
    // on TimeoutException catch (e) {
    //   showTimeOutError(
    //     context: context,
    //   );
    // } on SocketException catch (e) {
    //   showNoInternetError(
    //     context: context,
    //   );
    // }
    on Error catch (e) {
      print('Get credit transactions Error: $e');
    }
    return totalNumberOfCreditTransactions;
  }

  Future<int> getTotalNumberOfDebitTransactions({
    required BuildContext context,
  }) async {
    int totalNumberOfDebitTransactions = 0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getNumberOfCreditTransactions"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfDebitTransactions = jsonDecode(res.body);
          });
    }
    // on TimeoutException catch (e) {
    //   showTimeOutError(
    //     context: context,
    //   );
    // } on SocketException catch (e) {
    //   showNoInternetError(
    //     context: context,
    //   );
    // }
    on Error catch (e) {
      print('Get debit transactions Error: $e');
    }
    return totalNumberOfDebitTransactions;
  }
}
