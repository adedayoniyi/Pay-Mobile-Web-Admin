import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/settings/services/settings_services.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';


class CreateAdminScreen extends StatefulWidget {
  static const route = '/create-admin';
  const CreateAdminScreen({super.key});

  @override
  State<CreateAdminScreen> createState() => _CreateAdminScreenState();
}

class _CreateAdminScreenState extends State<CreateAdminScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureText = true;
  bool obscureText2 = true;

  String? errorText;
  String? successMessage = '';
  String misMatchPasswordErrorText = '';

  final SettingsServices settingsServices = SettingsServices();
  final createAdminFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void createAdmin() async {
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (createAdminFormKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        settingsServices.createAdmin(
          context: context,
          fullname: fullnameController.text,
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          type: typeController.text,
        );
      } else {
        setState(() {
          misMatchPasswordErrorText = "Passwords Do not Match";
        });
      }
    }
  }

  getAvailableUsername() async {
    errorText = await settingsServices.checkAvailableUsername(
        context: context,
        username: usernameController.text,
        onSuccess: () {
          if (usernameController.text.isNotEmpty) {
            setState(() {
              successMessage = "This username is available";
            });
          } else {
            setState(() {
              successMessage = '';
            });
          }
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appBar: CustomAppBar(image: logo),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeightSpace(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "Create Admin Or Agent",
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
      key: createAdminFormKey,
      child: Center(
        child: SizedBox(
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
                      prefixIcon: const Icon(Icons.alternate_email),
                      controller: usernameController,
                      errorText: errorText == "This username has been taken"
                          ? errorText
                          : null,
                      successMessage:
                          errorText == "This username has been taken"
                              ? ""
                              : successMessage,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          getAvailableUsername();
                        }
                      },
                    ),
                  ),
                ],
              ),
              CustomTextField(
                labelText: "Full Name",
                hintText: "Enter your full name",
                controller: fullnameController,
                // validator: validateName,
              ),
              CustomTextField(
                labelText: "Email",
                hintText: "Enter your email address",
                controller: emailController,
                // validator: validateEmail,
              ),
              CustomTextField(
                labelText: "Type",
                hintText: "Enter admin type e.g \"admin or \"agent ",
                controller: typeController,
                // validator: validateEmail,
              ),
              CustomTextField(
                obscureText: obscureText,
                labelText: "Password",
                hintText: "Enter your password",
                controller: passwordController,
                errorText: misMatchPasswordErrorText.isNotEmpty
                    ? misMatchPasswordErrorText
                    : null,
                icon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              CustomTextField(
                errorText: misMatchPasswordErrorText.isNotEmpty
                    ? misMatchPasswordErrorText
                    : null,
                obscureText: obscureText2,
                labelText: "Confirm Password",
                hintText: "Enter your password",
                controller: confirmPasswordController,
                icon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText2 = !obscureText2;
                    });
                  },
                  child: Icon(
                    obscureText2 ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              CustomButton(
                buttonText: "Create Admin",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () {
                  createAdmin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
