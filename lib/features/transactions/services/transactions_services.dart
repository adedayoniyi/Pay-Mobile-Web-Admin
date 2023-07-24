// ignore_for_file: use_build_context_synchronously, avoid_print, unused_catch_clause

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/features/transactions/models/transactions_model.dart';

import 'package:provider/provider.dart';

class TransactionServices {
  Future<List<Transactions>> getAllUserTransactions({
    required BuildContext context,
  }) async {
    List<Transactions> transactions = [];

    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      //showDialogLoader(context);
      //CircularProgressIndicator();
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getAllUserTransactions"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userToken,
        },
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      switch (res.statusCode) {
        case 200:
          transactions = (json.decode(res.body) as List)
              .map((data) => Transactions.fromJson(data))
              .toList();
          print(res.statusCode);
          break;
        case 400:
          print("No transactions found!!");
          transactions = [];
          break;
        case 500:
          print("Get Transactions Error");
      }
    } on Error catch (e) {
      print('Get All Transactions Error: $e');
    }
    return transactions;
  }
}
