// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallet_track/functions/db_functions.dart';
import 'package:wallet_track/screens/add_transactions_page.dart';
import 'package:wallet_track/screens/analysis_page.dart';
import 'package:wallet_track/screens/home_page.dart';
import 'package:wallet_track/screens/settings_page.dart';
import 'package:wallet_track/screens/transaction_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  final List<Widget> pages = [
    const DashBoard(),
    const AnalysisPage(),
    const TransactionPage(),
    const SettingsPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashBoard();

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 240, 191, 28),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTransactionPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: Color.fromARGB(255, 7, 7, 8),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = DashBoard();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Color.fromARGB(255, 253, 187, 45)
                              : Color.fromARGB(255, 175, 164, 164),
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color.fromARGB(255, 253, 187, 45)
                                : Color.fromARGB(255, 175, 164, 164),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = AnalysisPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pie_chart,
                          color: currentTab == 1
                              ? Color.fromARGB(255, 253, 187, 45)
                              : Color.fromARGB(255, 175, 164, 164),
                        ),
                        Text(
                          "Analysis",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color.fromARGB(255, 253, 187, 45)
                                : Color.fromARGB(255, 175, 164, 164),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = TransactionPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list,
                          color: currentTab == 3
                              ? Color.fromARGB(255, 253, 187, 45)
                              : Color.fromARGB(255, 175, 164, 164),
                        ),
                        Text(
                          "Transactions",
                          style: TextStyle(
                            color: currentTab == 3
                                ? Color.fromARGB(255, 253, 187, 45)
                                : Color.fromARGB(255, 175, 164, 164),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingsPage();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab == 4
                              ? Color.fromARGB(255, 253, 187, 45)
                              : Color.fromARGB(255, 175, 164, 164),
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                            color: currentTab == 4
                                ? Color.fromARGB(255, 253, 187, 45)
                                : Color.fromARGB(255, 175, 164, 164),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
