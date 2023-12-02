// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/data_model.dart';
import 'package:money_management/functions/db_functions.dart';
import 'package:money_management/screens/dashboard.dart';
import 'package:money_management/screens/name_screen.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkUserLoggedIn();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const NamePage()));
  }

  Future<void> checkUserLoggedIn() async {
    // print("Opening Hive box...");
    final box = await Hive.openBox<UserNameModel>("username_db");
    // print("Is box open: ${box.isOpen}");
    // print("Is box empty: ${box.isEmpty}");
    if (box.isOpen && box.isEmpty) {
      await gotoLogin();
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx1) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 103, 77, 67),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image(
                image: AssetImage('images/Logo.jpg'),
                width: 100,
                height: 90,
              ),
            ),
            SizedBox(height: 20),
            SpinKitRing(
              color: Colors.yellow,
              lineWidth: 4,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
