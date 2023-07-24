import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/features/auth/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    fullname: '',
    username: '',
    email: '',
    password: '',
    token: '',
    type: '',
    id: '',
    pin: '',
    deviceToken: '',
    isVerified: false,
  );

  //creating getter for user
  User get user => _user;

  void setUser(String user) {
    //data fromjson coming from models/user.dart
    _user = User.fromJson(user);
    notifyListeners();
  }
}
