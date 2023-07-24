import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/change_admin_auth_pin_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/create_admin_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/delete_admin_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/widgets/settings_card.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            HeightSpace(15),
            SettingsCard(
                icon: Icons.person,
                settingsOperation: "Create Admin",
                settingsOperationDescription: "Create a new admin or agent",
                onPressed: () {
                  namedNav(context, CreateAdminScreen.route);
                }),
            HeightSpace(15),
            SettingsCard(
                icon: Icons.delete,
                settingsOperation: "Delete Admin Or User",
                settingsOperationDescription:
                    "Delete an existing admin or agent",
                onPressed: () {
                  namedNav(context, DeleteAdminScreen.route);
                }),
            HeightSpace(15),
            SettingsCard(
                icon: Icons.password,
                settingsOperation: "Change Authorization Pin",
                settingsOperationDescription:
                    "Change the authorizatin pin for approving sensitive requests",
                onPressed: () {
                  namedNav(context, ChangeAdminAuthScreen.route);
                })
          ],
        ),
      ),
    );
  }
}
