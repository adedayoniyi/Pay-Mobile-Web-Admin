import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/config/routes/custom_push_navigators.dart';
import 'package:pay_mobile_web_admin/core/utils/assets.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/features/auth/screens/login_screen.dart';
import 'package:pay_mobile_web_admin/features/chat/screens/chat_list_screen.dart';
import 'package:pay_mobile_web_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:pay_mobile_web_admin/features/notifications/screens/send_push_notifications_screen.dart';
import 'package:pay_mobile_web_admin/features/settings/screens/settings_screen.dart';
import 'package:pay_mobile_web_admin/features/transactions/screens/user_transactions_screen.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static const String route = "/home";
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _pages = [
    const DashboardScreen(),
    const UserTransactionsScreen(),
    const SendPushNotificationsScreen(),
    const ChatListScreen(),
    const SettingsScreen()
  ];

  late PageController _pageController;

  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.pop(context);
      }
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      namedNavRemoveUntil(
        context,
        LoginScreen.route,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop &&
        orientation == Orientation.landscape;
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      key: _scaffoldKey,
      drawer: isDesktop
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpace(15),
                  Image.asset(
                    mainLogo,
                    height: 40,
                  ),
                  const HeightSpace(15),
                  CircleAvatar(
                    radius: 40,
                    child: Center(
                      child: Text(
                        userProvider.fullname[0],
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  const HeightSpace(15),
                  const HeightSpace(5),
                  Text(userProvider.email),
                  ListTile(
                    title: const Text('Dashboard'),
                    leading: const Icon(Icons.space_dashboard_rounded),
                    selected: _currentIndex == 0,
                    onTap: () => _changePage(0),
                  ),
                  ListTile(
                    title: const Text('User Transactions'),
                    leading: const Icon(Icons.send_rounded),
                    selected: _currentIndex == 1,
                    onTap: () => _changePage(1),
                  ),
                  userProvider.type == "agent" || userProvider.type == "user"
                      ? const SizedBox.shrink()
                      : ListTile(
                          title: const Text('Send Notifications'),
                          leading: const Icon(Icons.notifications),
                          selected: _currentIndex == 2,
                          onTap: () => _changePage(2),
                        ),
                  ListTile(
                    title: const Text('User Chat'),
                    leading: const Icon(Icons.question_answer_outlined),
                    selected: _currentIndex == 3,
                    onTap: () => _changePage(3),
                  ),
                  userProvider.type == "agent" || userProvider.type == "user"
                      ? const SizedBox.shrink()
                      : ListTile(
                          title: const Text('Settings'),
                          leading: const Icon(Icons.settings),
                          selected: _currentIndex == 4,
                          onTap: () => _changePage(4),
                        ),
                  CustomButton(
                      buttonText: "Log Out",
                      buttonTextColor: secondaryAppColor,
                      onTap: () {
                        logOut(context);
                      }),
                ],
              ),
            ),
      appBar: isDesktop
          ? null
          : AppBar(
              leading: isDesktop
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                    ),
            ),
      body: Row(
        children: [
          if (isDesktop)
            Container(
              width: screenWidth / 5,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const HeightSpace(15),
                    Image.asset(
                      mainLogo,
                      height: 40,
                    ),
                    const HeightSpace(15),
                    CircleAvatar(
                      radius: 40,
                      child: Center(
                        child: Text(
                          userProvider.fullname[0],
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const HeightSpace(15),
                    Center(
                      child: Text(
                          "${userProvider.fullname} (${userProvider.type.toUpperCase()})"),
                    ),
                    const HeightSpace(5),
                    Center(child: Text(userProvider.email)),
                    const HeightSpace(10),
                    userProvider.type == "agent" || userProvider.type == "user"
                        ? Container(
                            height: 90,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: greyScale850,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    infoCircle,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                  const Text(
                                    "Please Note, AGENT accounts have limited features",
                                    style: TextStyle(fontSize: 13),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const HeightSpace(10),
                    ListTile(
                      title: const Text('Dashboard'),
                      leading: const Icon(Icons.space_dashboard_rounded),
                      selected: _currentIndex == 0,
                      onTap: () => _changePage(0),
                    ),
                    ListTile(
                      title: const Text('User Transactions'),
                      leading: const Icon(Icons.send_rounded),
                      selected: _currentIndex == 1,
                      onTap: () => _changePage(1),
                    ),
                    userProvider.type == "agent" || userProvider.type == "user"
                        ? const SizedBox.shrink()
                        : ListTile(
                            title: const Text('Send Notifications'),
                            leading: const Icon(Icons.notifications),
                            selected: _currentIndex == 2,
                            onTap: () => _changePage(2),
                          ),
                    ListTile(
                      title: const Text('User Chat'),
                      leading: const Icon(Icons.question_answer_outlined),
                      selected: _currentIndex == 3,
                      onTap: () => _changePage(3),
                    ),
                    userProvider.type == "agent" || userProvider.type == "user"
                        ? const SizedBox.shrink()
                        : ListTile(
                            title: const Text('Settings'),
                            leading: const Icon(Icons.settings),
                            selected: _currentIndex == 4,
                            onTap: () => _changePage(4),
                          ),
                    const HeightSpace(10),
                    CustomButton(
                        buttonText: "Log Out",
                        buttonTextColor: secondaryAppColor,
                        onTap: () {
                          logOut(context);
                        }),
                  ],
                ),
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
