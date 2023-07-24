import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/features/transactions/models/transactions_model.dart';
import 'package:pay_mobile_web_admin/features/transactions/screens/transaction_details_screen.dart';
import 'package:pay_mobile_web_admin/features/transactions/services/transactions_services.dart';
import 'package:pay_mobile_web_admin/widgets/circular_loader.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/transactions_card.dart';

class UserTransactionsScreen extends StatefulWidget {
  static const String route = "/transactions-screen";
  const UserTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<UserTransactionsScreen> createState() => _UserTransactionsScreenState();
}

class _UserTransactionsScreenState extends State<UserTransactionsScreen> {
  List<Transactions> transactions = [];
  List<Transactions> filteredTransactions = [];
  final TransactionServices transactionServices = TransactionServices();
  late Future _future;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = getAllTransactions();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredTransactions = transactions;
      } else {
        filteredTransactions = transactions
            .where((transaction) =>
                transaction.reference.contains(searchController.text))
            .toList();
      }
    });
  }

  getAllTransactions() async {
    transactions = await transactionServices.getAllUserTransactions(
      context: context,
    );
    setState(() {
      filteredTransactions = transactions;
    });
  }

  String getTransactionDateText(DateTime transactionDate) {
    DateTime now = DateTime.now();
    int hoursDiff = now.difference(transactionDate).inHours;
    int daysDiff = now.difference(transactionDate).inDays;
    String formattedDate = DateFormat.yMMMd().format(transactionDate);
    if (hoursDiff < 3) {
      return "Recent";
    } else if (daysDiff == 0) {
      return "Today";
    } else if (daysDiff == 1) {
      return "Yesterday";
    } else {
      return formattedDate;
    }
  }

  Map<String, List<Transactions>> groupTransactionsByDateText(
      List<Transactions> transactionsToGroup) {
    Map<String, List<Transactions>> groups = {};
    for (Transactions transaction in transactionsToGroup) {
      String dateText = getTransactionDateText(transaction.createdAt);
      if (groups.containsKey(dateText)) {
        groups[dateText]!.add(transaction);
      } else {
        groups[dateText] = [transaction];
      }
    }
    return groups;
  }

  List<String> getTrnxSummary(transactionData) {
    if (transactionData.trnxType == "Credit") {
      return [
        "Reference:${transactionData.reference}",
        "assets/icons/credit_icon.png"
      ];
    } else if (transactionData.trnxType == "Debit") {
      return [
        "Reference:${transactionData.reference}",
        "assets/icons/debit_icon.png"
      ];
    } else if (transactionData.trnxType == "Wallet Funding") {
      return [
        "Reference:${transactionData.reference}",
        "assets/icons/add_icon.png"
      ];
    } else {
      return ["Hello"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return transactions.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty_list.png"),
                        const Text(
                          "You've not made any transactions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                            buttonText: "Chae",
                            buttonTextColor: whiteColor,
                            onTap: () => getAllTransactions())
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          "User Transactions",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "Search transactions reference ",
                          controller: searchController,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            displacement: 100,
                            onRefresh: () => getAllTransactions(),
                            child: ListView.builder(
                              itemCount: groupTransactionsByDateText(
                                      filteredTransactions)
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                List<String> keys = groupTransactionsByDateText(
                                        filteredTransactions)
                                    .keys
                                    .toList();
                                String key = keys[index];
                                List<Transactions> transactionsList =
                                    groupTransactionsByDateText(
                                        filteredTransactions)[key]!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      key,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transactionsList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final transactionData =
                                            transactionsList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return TransactionDetailsScreen(
                                                    transactions:
                                                        transactionData);
                                              },
                                            ));
                                          },
                                          child: TransactionsCard(
                                            transactionTypeImage:
                                                getTrnxSummary(
                                                    transactionData)[1],
                                            transactionType:
                                                transactionData.trnxType,
                                            trnxSummary: getTrnxSummary(
                                                transactionData)[0],
                                            amount: transactionData.amount,
                                            amountColorBasedOnTransactionType:
                                                transactionData.trnxType ==
                                                        "Debit"
                                                    ? Colors.red
                                                    : Colors.green,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          } else {}
          return const CircularLoader();
        },
      ),
    );
  }
}
