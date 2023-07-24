import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/services/auth_service.dart';
import 'package:pay_mobile_web_admin/features/settings/services/settings_services.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';

import 'package:provider/provider.dart';

class DeleteAdminScreen extends StatefulWidget {
  static const route = '/delete-admin';
  const DeleteAdminScreen({super.key});

  @override
  State<DeleteAdminScreen> createState() => _DeleteAdminScreenState();
}

class _DeleteAdminScreenState extends State<DeleteAdminScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  bool obscureText = true;

  String? errorText;
  String? successMessage = '';

  final SettingsServices settingsServices = SettingsServices();
  final deleteAdminFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    pinController.dispose();
  }

  void deleteAdmin() async {
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (deleteAdminFormKey.currentState!.validate()) {
      settingsServices.deleteAdmin(
        context: context,
        username: usernameController.text,
        authorizationPin: pinController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appBar: CustomAppBar(image: logo),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeightSpace(10),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "Delete Admin",
                      style: TextStyle(
                        fontSize: heightValue37,
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                      ),
                    ),
                  ),
                  formUI()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Form(
      key: deleteAdminFormKey,
      child: Center(
        child: Container(
          width: 400,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      willContainPrefix: true,
                      labelText: "Username",
                      hintText: "Username",
                      prefixIcon: Icon(Icons.alternate_email),
                      controller: usernameController,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                labelText: "Type",
                hintText: "Enter Admin Authorization Pin",
                controller: pinController,
                // validator: validateEmail,
              ),
              CustomButton(
                buttonText: "Delete Admin",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () {
                  deleteAdmin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
