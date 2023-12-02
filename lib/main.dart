import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/data_model.dart';
import 'package:money_management/db/transaction_data_model.dart';
import 'package:money_management/functions/db_transaction_functions.dart';
import 'package:money_management/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserNameModelAdapter().typeId)) {
    Hive.registerAdapter(UserNameModelAdapter());
  }
  runApp(const MoneyManagementApp());
}

class MoneyManagementApp extends StatelessWidget {
  const MoneyManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    getAllTransactions();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Money Management",
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 70, 67, 67),
      ),
      home: const SplashScreeen(),
    );
  }
}
