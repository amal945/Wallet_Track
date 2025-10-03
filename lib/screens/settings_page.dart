// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_track/db/data_model.dart';
import 'package:wallet_track/db/transaction_data_model.dart';
import 'package:wallet_track/functions/db_functions.dart';
import 'package:wallet_track/functions/db_transaction_functions.dart';
import 'package:wallet_track/screens/about.dart';
import 'package:wallet_track/screens/invite_friends.dart';
import 'package:wallet_track/screens/name_screen.dart';
import 'package:wallet_track/screens/privacy_policy.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 400;

    return ValueListenableBuilder<List<UserNameModel>>(
      valueListenable: userNameNotifier,
      builder: (context, username, child) {
        // Safely handle empty list
        if (username.isEmpty) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 32, 30, 30),
            body: const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            ),
          );
        }

        final _userName = username[0];

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 32, 30, 30),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 36, left: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: isSmallScreen ? 30 : 40,
                        child: Icon(
                          Icons.person,
                          size: isSmallScreen ? 50 : 67,
                          color: const Color.fromARGB(255, 173, 170, 170),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 15 : 25),
                      Text(
                        _userName.userName.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 15 : 25),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: double.infinity,
                      height: isSmallScreen ? 215 : 245,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 110, 100, 95),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // First Row
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InviteFriendsPage(),
                                ),
                              );
                            },
                            child: buildMenuItem(
                              Icon(Icons.co_present,
                                  color: const Color.fromARGB(255, 253, 187, 45),
                                  size: isSmallScreen ? 24 : 34),
                              "Recommend to Friends",
                              isSmallScreen,
                            ),
                          ),
                          const Divider(color: Colors.black),
                          // 2nd row
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy(),
                                ),
                              );
                            },
                            child: buildMenuItem(
                              Icon(Icons.policy,
                                  color: const Color.fromARGB(255, 253, 187, 45),
                                  size: isSmallScreen ? 24 : 34),
                              "Privacy Policy",
                              isSmallScreen,
                            ),
                          ),
                          const Divider(color: Colors.black),
                          // 3rd row
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => About(),
                                ),
                              );
                            },
                            child: buildMenuItem(
                              Icon(Icons.assignment,
                                  color: const Color.fromARGB(255, 253, 187, 45),
                                  size: isSmallScreen ? 24 : 34),
                              "About App",
                              isSmallScreen,
                            ),
                          ),
                          const Divider(color: Colors.black),
                          // Logout row
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                    const Color.fromARGB(255, 52, 48, 48),
                                    title: const Text(
                                      "Are you sure...?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      "All your data will be lost.....!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.yellow),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          signOutButton(context);
                                        },
                                        child: const Text(
                                          "Continue",
                                          style: TextStyle(color: Colors.yellow),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: buildMenuItem(
                              Icon(Icons.exit_to_app,
                                  color: const Color.fromARGB(255, 253, 187, 45),
                                  size: isSmallScreen ? 24 : 34),
                              "Log Out",
                              isSmallScreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMenuItem(Icon icon, String text, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: isSmallScreen ? 10 : 20),
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white, fontSize: isSmallScreen ? 18 : 23.5),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  signOutButton(BuildContext ctx) async {
    final userDB = await Hive.openBox<UserNameModel>("username_db");
    await userDB.clear();
    final transactionDB =
    await Hive.openBox<TransactionModel>("transaction_db");
    await transactionDB.clear();
    clearUserData();
    clearAllData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (ctx) => const NamePage()),
          (route) => false,
    );
  }
}
