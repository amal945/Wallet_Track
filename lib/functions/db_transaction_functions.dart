// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/transaction_data_model.dart';
import 'package:uuid/uuid.dart';

ValueNotifier<List<TransactionModel>> transactionListNotifier =
    ValueNotifier([]);

Future<void> addTransaction(TransactionModel data) async {
  final transactionDB = await Hive.openBox<TransactionModel>("transaction_db");
  final id = const Uuid().v4();
  data.id = id;
  await transactionDB.put(id, data);
  transactionListNotifier.value.add(data);
  transactionListNotifier.notifyListeners();
  getAllTransactions();
}

Future<void> getAllTransactions() async {
  final transactionDB = await Hive.openBox<TransactionModel>("transaction_db");
  transactionListNotifier.value.clear();
  transactionListNotifier.value.addAll(transactionDB.values);
  transactionListNotifier.notifyListeners();
}

Future<void> clearAllData() async {
  final box = await Hive.openBox<TransactionModel>("transaction_db");
  await box.clear();
  transactionListNotifier.value.clear();
}

Future<void> deleteTransaction(String id) async {
  final transactionDB = await Hive.openBox<TransactionModel>("transaction_db");
  transactionDB.delete(id);
  getAllTransactions();
}

Future<void> updateTransaction(TransactionModel updatedData) async {
  final transactionDB = await Hive.openBox<TransactionModel>("transaction_db");
  await transactionDB.put(updatedData.id, updatedData);
  final existingTransactionIndex = transactionListNotifier.value
      .indexWhere((transaction) => transaction.id == updatedData.id);

  if (existingTransactionIndex != -1) {
    transactionListNotifier.value[existingTransactionIndex] = updatedData;
    transactionListNotifier.notifyListeners();
  }

  getAllTransactions();
}

int totals = 0;

final box = Hive.box<TransactionModel>('transaction_db');

int total() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].category == 'income'
        ? (history2[i].amount)
        : (history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  getAllTransactions();
  return totals;
}

int income() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].category == 'income' ? (history2[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  getAllTransactions();
  return totals;
}

int expense() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].category == 'income' ? 0 : (history2[i].amount) * 1);
  }
  totals = a.reduce((value, element) => value + element);
  getAllTransactions();
  return totals;
}

List<TransactionModel> today() {
  List<TransactionModel> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].date.day == date.day) {
      a.add(history2[i]);
    }
  }
  getAllTransactions();
  return a;
}

List<TransactionModel> Week() {
  List<TransactionModel> a = [];
  DateTime date = DateTime.now();
  var history2 = box.values.toList();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].date.day &&
        history2[i].date.day <= date.day) {
      a.add(history2[i]);
    }
  }
  getAllTransactions();
  return a;
}

List<TransactionModel> month() {
  List<TransactionModel> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].date.month == date.month) {
      a.add(history2[i]);
    }
  }
  getAllTransactions();
  return a;
}

List<TransactionModel> year() {
  List<TransactionModel> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].date.year == date.year) {
      a.add(history2[i]);
    }
  }
  getAllTransactions();
  return a;
}

int total_chart(List<TransactionModel> history2) {
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].category == 'income'
        ? (history2[i].amount)
        : (history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  getAllTransactions();
  return totals;
}

List time(List<TransactionModel> history2, bool hour) {
  List<TransactionModel> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].date.hour == history2[c].date.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].date.day == history2[c].date.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  // print(total);
  getAllTransactions();
  return total;
}
