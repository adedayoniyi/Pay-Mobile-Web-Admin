import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/services/auth_service.dart';
import 'package:pay_mobile_web_admin/features/settings/services/settings_services.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';

import 'package:provider/provider.dart';

class ChangeAdminAuthScreen extends StatefulWidget {
  static const route = '/change-admin-auth-pin';
  const ChangeAdminAuthScreen({super.key});

  @override
  State<ChangeAdminAuthScreen> createState() => _ChangeAdminAuthScreenState();
}

class _ChangeAdminAuthScreenState extends State<ChangeAdminAuthScreen> {
  final TextEditingController oldPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController uniqueAdminUsername = TextEditingController();

  bool obscureText = true;

  final SettingsServices settingsServices = SettingsServices();
  final changeAdminAuthPinFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    oldPinController.dispose();
    newPinController.dispose();
    uniqueAdminUsername.dispose();
  }

  void deleteAdmin() async {
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (changeAdminAuthPinFormKey.currentState!.validate()) {
      settingsServices.changeAdminAuthorizationPin(
        context: context,
        oldAdminAuthPin: oldPinController.text,
        newAdminAuthPin: newPinController.text,
        admin: uniqueAdminUsername.text,
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
                      "Change Admin Auth Pin",
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
      key: changeAdminAuthPinFormKey,
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
                      labelText: "Old Pin",
                      hintText: "Enter OldPin",
                      controller: oldPinController,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                labelText: "New Pin",
                hintText: "Enter New Authorization Pin",
                controller: newPinController,
                // validator: validateEmail,
              ),
              CustomTextField(
                labelText: "Unique Admin Username",
                hintText: "Enter Unique Admin Username",
                controller: newPinController,
                // validator: validateEmail,
              ),
              CustomButton(
                buttonText: "Update Pin",
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
