import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/assets.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/features/dashboard/services/dashboard_services.dart';
import 'package:pay_mobile_web_admin/features/dashboard/widgets/dashboard_container.dart';
import 'package:pay_mobile_web_admin/features/transactions/models/transactions_model.dart';
import 'package:pay_mobile_web_admin/features/transactions/services/transactions_services.dart';
import 'package:pay_mobile_web_admin/widgets/circular_loader.dart';
import 'package:pay_mobile_web_admin/widgets/width_space.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class DashboardScreen extends StatefulWidget {
  static const String route = "/dashboard";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashBoardServices dashBoardServices = DashBoardServices();
  int totalNumberOfUserTransactions = 0;
  int totalNumberOfUserBalance = 0;
  int totalNumberOfUsers = 0;
  int totalNumberOfWalletFundings = 0;
  int totalNumberOfCreditTransactions = 0;
  int totalNumberOfDebitTransactions = 0;
  List<Transactions> transactions = [];
  final TransactionServices transactionServices = TransactionServices();
  late Future future;
  List<String> mainData = [];

  List<Color> colors = [
    const Color(0xFFb8c2b7),
    const Color(0xFFb0d2c2),
    const Color(0xFFb9b6c1),
    const Color(0xFFB3E0B8),
    const Color(0xFFAEC4E0),
    const Color(0xFFC5AEE0),
    const Color(0xFFE0AEC4),
    Color(0xFFb4b5b9),
    Color(0xFFd2b48c),
    //Colors.purple,
  ];
  List<bool> willContainRow = [
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<Color> topIconsColor = [
    darken(const Color(0xFFb8c2b7), 0.2),
    darken(const Color(0xFFb0d2c2), 0.2),
    darken(const Color(0xFFb9b6c1), 0.2),
    darken(const Color(0xFFB3E0B8), 0.2),
    darken(const Color(0xFFAEC4E0), 0.2),
    darken(const Color(0xFFC5AEE0), 0.2),
    darken(const Color(0xFFE0AEC4), 0.2),
    darken(const Color(0xFFb4b5b9), 0.2),
    darken(const Color(0xFFd2b48c), 0.2),
  ];
  List<String> title = [
    "Total Transactions",
    "Total User Balance",
    "Total Users",
    "Wallet Fundings",
    "Debit Transactions",
    "Credit Transactions",
    "Airtime",
    "Data",
    "Electricity",
  ];
  final List<String> topIcons = [
    transactionsIcon,
    nairaIcon,
    profileIcon,
    addIcon,
    creditIcon,
    debitIcon,
    mobileIcon,
    wifiIcon,
    electricityIcon,
  ];

  getAllTransactions() async {
    transactions = await transactionServices.getAllUserTransactions(
      context: context,
    );
    setState(() {
      print(transactions);
    });
  }

  getDashBoardData() async {
    totalNumberOfUserTransactions =
        await dashBoardServices.getTotalTransactions(
      context: context,
    );
    totalNumberOfUserBalance = await dashBoardServices.getTotalUserBalance(
      context: context,
    );
    totalNumberOfUsers = await dashBoardServices.getTotalNumberOfUsers(
      context: context,
    );
    totalNumberOfWalletFundings = await dashBoardServices
        .getTotalNumberOfWalletFundings(context: context);
    totalNumberOfCreditTransactions = await dashBoardServices
        .getTotalNumberOfDebitTransactions(context: context);
    totalNumberOfDebitTransactions = await dashBoardServices
        .getTotalNumberOfDebitTransactions(context: context);
    mainData = [
      totalNumberOfUserTransactions.toString(),
      totalNumberOfUserBalance.toString(),
      totalNumberOfUsers.toString(),
      totalNumberOfWalletFundings.toString(),
      totalNumberOfCreditTransactions.toString(),
      totalNumberOfDebitTransactions.toString(),
      0.toString(),
      0.toString(),
      0.toString(),
    ];
  }

  @override
  void initState() {
    super.initState();
    future = getDashBoardData();
    //getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Dashboard",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidthSpace(20),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        border: Border.all(color: greyScale600),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.question_mark_rounded,
                          size: 20,
                          color: greyScale600,
                        ),
                      ),
                    )
                  ],
                ),
                const Icon(Icons.notifications)
              ],
            ),
          ),
          if (ResponsiveBreakpoints.of(context).isMobile)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                ),
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return DashboardContainer(
                          color: colors[index],
                          title: title[index],
                          mainData: mainData[index],
                          topIcon: topIcons[index],
                          topIconColor: topIconsColor[index],
                          willContainRow: willContainRow[index],
                        );
                      } else {}
                      return CircularLoader();
                    },
                  );
                },
              ),
            ),
          if (ResponsiveBreakpoints.of(context).isTablet)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return DashboardContainer(
                          color: colors[index],
                          title: title[index],
                          mainData: mainData[index],
                          topIcon: topIcons[index],
                          topIconColor: topIconsColor[index],
                          willContainRow: willContainRow[index],
                        );
                      } else {}
                      return CircularLoader();
                    },
                  );
                },
              ),
            ),
          if (ResponsiveBreakpoints.of(context).isDesktop)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                ),
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return DashboardContainer(
                          color: colors[index],
                          title: title[index],
                          mainData: mainData[index],
                          topIcon: topIcons[index],
                          topIconColor: topIconsColor[index],
                          willContainRow: willContainRow[index],
                        );
                      } else {}
                      return CircularLoader();
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
