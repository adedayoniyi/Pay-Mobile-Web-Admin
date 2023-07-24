import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pay_mobile_web_admin/config/routes/router.dart';
import 'package:pay_mobile_web_admin/config/theme/theme_manager.dart';
import 'package:pay_mobile_web_admin/features/auth/screens/login_screen.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/features/auth/services/auth_service.dart';
import 'package:pay_mobile_web_admin/widgets/circular_loader.dart';
import 'package:pay_mobile_web_admin/widgets/home.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future _future;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _future = obtainTokenAndUserData(context);
  }

  obtainTokenAndUserData(BuildContext context) async {
    await authService.obtainTokenAndUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final ThemeManager themeManager = ThemeManager();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeManager.darkTheme,
      darkTheme: themeManager.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 600, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return user.type == "admin" ||
                    user.type == "agent" && user.token.isNotEmpty
                ? const Home()
                : const LoginScreen();
          } else {}

          return const Scaffold(body: CircularLoader());
        },
      ),
      //initialRoute: "/login",
      onGenerateRoute: (settings) => appRoutes(settings),
    );
  }
}
