import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_web_admin/core/utils/assets.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/validators.dart';
import 'package:pay_mobile_web_admin/features/auth/services/auth_service.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/home.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  loginAdmin() {
    if (loginFormKey.currentState!.validate()) {
      authService.loginInAdmin(
          context: context,
          email: emailController.text,
          password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginFormKey,
        child: Column(
          children: [
            Image.asset(
              mainLogo,
              height: heightValue70,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(heightValue20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 5),
                  child: Container(
                    height: heightValue400,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(heightValue20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: heightValue20,
                            ),
                          ),
                          CustomTextField(
                            hintText: "Email",
                            controller: emailController,
                            validator: validateEmail,
                          ),
                          CustomTextField(
                            hintText: "Password",
                            controller: passwordController,
                            //validator: validatePassword,
                          ),
                          CustomButton(
                            buttonText: "Login",
                            buttonTextColor: secondaryAppColor,
                            borderRadius: heightValue30,
                            onTap: () {
                              loginAdmin();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
