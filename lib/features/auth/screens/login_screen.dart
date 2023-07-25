import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/assets.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/validators.dart';
import 'package:pay_mobile_web_admin/features/auth/services/auth_service.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

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
  double screenWidthValue = 0;

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
    final screenWidthValue = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Row(
            mainAxisAlignment: ResponsiveBreakpoints.of(context).isDesktop
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: [
              ResponsiveBreakpoints.of(context).isDesktop
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Web Admin",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          loginScreenImage,
                          height: screenWidthValue * 0.42,
                          width: screenWidthValue * 0.42,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                width: 380,
                child: Stack(
                  children: [
                    Positioned(
                      top: 110,
                      child: Image.asset(
                        gradientCircle,
                        height: 100,
                      ),
                    ),
                    Positioned(
                      top: 230,
                      left: 250,
                      child: Image.asset(
                        gradientCircle,
                        height: 100,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 185,
                      child: Image.asset(
                        gradientCircle,
                        height: 100,
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      left: 90,
                      child: Image.asset(
                        gradientCircle,
                        height: 75,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          mainLogo,
                          height: 70,
                        ),
                        const HeightSpace(20),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 400,
                                width:
                                    ResponsiveBreakpoints.of(context).isMobile
                                        ? screenWidthValue / 1.3
                                        : 350,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const HeightSpace(10),
                                      CustomTextField(
                                        hintText: "Email",
                                        controller: emailController,
                                        validator: validateEmail,
                                      ),
                                      CustomTextField(
                                        hintText: "Password",
                                        controller: passwordController,
                                        validator: validateField,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
