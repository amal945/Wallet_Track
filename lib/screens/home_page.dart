// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/db_functions.dart';
import 'package:money_management/functions/db_transaction_functions.dart';
import 'package:money_management/screens/edit_transaction_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final Map<String, IconData> categoryIcons = {
    "Food": Icons.fastfood,
    "Shopping": Icons.shopping_cart,
    "Travel": Icons.route,
    "Entertainment": Icons.sports_esports,
    "Medical": Icons.health_and_safety,
    "Education": Icons.school,
    "Fitness": Icons.fitness_center,
    "Rent": Icons.home,
    "Other": Icons.more_horiz,
    "Coupons": Icons.redeem,
    "Sold Items": Icons.shopping_cart,
    "Salary": Icons.money,
  };

  final Map<IconData, Color> iconsColor = {
    Icons.fastfood: Colors.yellow,
    Icons.shopping_cart: Colors.lightBlue,
    Icons.route: Colors.purple,
    Icons.sports_esports: Colors.lightGreen,
    Icons.health_and_safety: Colors.red,
    Icons.school: Colors.purpleAccent,
    Icons.fitness_center: Colors.orange,
    Icons.home: Color.fromARGB(255, 18, 225, 25),
    Icons.more_horiz: Color.fromARGB(255, 139, 199, 249),
    Icons.redeem: Colors.purple,
    Icons.money: const Color.fromARGB(255, 245, 235, 152),
  };

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  double responsiveFontSize(double fontSize) {
    // You can customize this function based on your design and screen sizes
    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    getAllTransactions();
    getUser();
    final greeting = getGreeting();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 30, 30),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: transactionListNotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
              return ValueListenableBuilder(
                valueListenable: userNameNotifier,
                builder: (context, value, child) {
                  final _userName = value[0];
                  return Padding(
                    padding: EdgeInsets.only(top: responsiveFontSize(80)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: responsiveFontSize(60),
                        ),
                        Row(children: [
                          SizedBox(
                            width: responsiveFontSize(70),
                          ),
                          Text(
                            "Heyy..... ${_userName.userName.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: responsiveFontSize(30)),
                          ),
                        ]),
                        SizedBox(
                          height: responsiveFontSize(60),
                        ),
                        Text(
                          "You haven't added any data yet!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveFontSize(20)),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(responsiveFontSize(11)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveFontSize(25),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ValueListenableBuilder(
                        valueListenable: userNameNotifier,
                        builder: (context, value, child) {
                          final _userName = value[0];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                _userName.userName.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsiveFontSize(20),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: responsiveFontSize(45),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "This month",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveFontSize(18),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: transactionListNotifier,
                        builder: (context, transactionsData, child) {
                          int totalExpense = 0;
                          int totalIncome = 0;
                          final now = DateTime.now();

                          for (int i = 0; i < transactionsData.length; i++) {
                            final transaction = transactionsData[i];

                            if (transaction.category == "Expense" &&
                                transaction.date.month == now.month) {
                              totalExpense += transaction.amount;
                            } else if (transaction.category == "Income" &&
                                transaction.date.month == now.month) {
                              totalIncome += transaction.amount;
                            }
                          }
                          int balance = totalIncome - totalExpense;
                          if (balance < 0) {
                            balance = 0;
                          }

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Card(
                                      color: Colors.pink[300],
                                      elevation: responsiveFontSize(10),
                                      shadowColor: Colors.grey,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CircleAvatar(
                                            radius: responsiveFontSize(20),
                                            backgroundColor: Colors.pink[100],
                                            child: const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            height: responsiveFontSize(70),
                                            width: responsiveFontSize(110),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Expense",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        responsiveFontSize(18),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "₹$totalExpense",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        responsiveFontSize(20),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      color: Colors.green[300],
                                      elevation: responsiveFontSize(10),
                                      shadowColor: Colors.grey,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: responsiveFontSize(10),
                                          ),
                                          CircleAvatar(
                                            radius: responsiveFontSize(20),
                                            backgroundColor: Colors.green[100],
                                            child: Icon(
                                              Icons.arrow_downward,
                                              color: Colors.white,
                                              size: responsiveFontSize(30),
                                            ),
                                          ),
                                          Container(
                                            height: responsiveFontSize(70),
                                            width: responsiveFontSize(110),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: responsiveFontSize(5),
                                                ),
                                                Text(
                                                  "Income",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        responsiveFontSize(18),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: responsiveFontSize(5),
                                                ),
                                                Text(
                                                  "₹$totalIncome",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        responsiveFontSize(20),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsiveFontSize(15),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        responsiveFontSize(10)),
                                    color: Colors.grey),
                                width: responsiveFontSize(185),
                                height: responsiveFontSize(35),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Balance:₹$balance",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsiveFontSize(20),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveFontSize(80),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Recently Added",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: responsiveFontSize(20),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        color: const Color.fromARGB(255, 32, 30, 30),
                        child: Padding(
                          padding: EdgeInsets.all(responsiveFontSize(7.5)),
                          child: ValueListenableBuilder(
                            valueListenable: transactionListNotifier,
                            builder: (context, transactions, child) {
                              final recentTransactions =
                                  transactions.reversed.take(7).toList();

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  final data = recentTransactions[index];
                                  final categoryIcon =
                                      categoryIcons[data.categoryType] ??
                                          Icons.category;
                                  Color containerColor =
                                      data.category == "Expense"
                                          ? Color.fromARGB(255, 253, 187, 45)
                                          : Colors.green;
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        responsiveFontSize(12.0)),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                          motion: StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: ((context) {
                                                deleteTransaction(data.id);
                                              }),
                                              icon: Icons.delete,
                                              backgroundColor: Colors.red,
                                            )
                                          ]),
                                      child: Container(
                                        color: containerColor,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTransactionPage(
                                                        transactionData: data),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: responsiveFontSize(24),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 32, 30, 30),
                                              child: Icon(
                                                categoryIcon,
                                                color: iconsColor[categoryIcon],
                                                size: responsiveFontSize(35),
                                              ),
                                            ),
                                            title: Text(
                                              "₹${data.amount.toString()}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    responsiveFontSize(21),
                                              ),
                                            ),
                                            subtitle: Text(
                                              data.categoryType.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            trailing: Text(
                                              DateFormat('dd MMMM y')
                                                  .format(data.date),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return Divider(
                                    color:
                                        const Color.fromARGB(255, 32, 30, 30),
                                    height: responsiveFontSize(8),
                                  );
                                },
                                itemCount: recentTransactions.length,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
