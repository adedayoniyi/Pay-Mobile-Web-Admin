import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/features/auth/screens/login_screen.dart';
import 'package:pay_mobile_web_admin/features/chat/models/chat_model.dart';
import 'package:pay_mobile_web_admin/features/chat/screens/chat_screen.dart';
import 'package:pay_mobile_web_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/change_admin_auth_pin_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/create_admin_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/delete_admin_screen.dart';
import 'package:pay_mobile_web_admin/widgets/home.dart';

Route<dynamic> appRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
        settings: routeSettings,
      );
    case Home.route:
      return MaterialPageRoute(
        builder: (context) {
          return Home();
        },
        settings: routeSettings,
      );
    case DashboardScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const DashboardScreen();
        },
        settings: routeSettings,
      );
    case CreateAdminScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const CreateAdminScreen();
        },
        settings: routeSettings,
      );

    case DeleteAdminScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const DeleteAdminScreen();
        },
        settings: routeSettings,
      );

    case ChangeAdminAuthScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const ChangeAdminAuthScreen();
        },
        settings: routeSettings,
      );
    case ChatScreen.route:
      var chatModel = routeSettings.arguments as ChatModel;
      return MaterialPageRoute(
        builder: (context) {
          return ChatScreen(
            chatModel: chatModel,
          );
        },
        settings: routeSettings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Sorry, This page dosen't exist"),
          ),
        ),
      );
  }
}
