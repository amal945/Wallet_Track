// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/data_model.dart';

ValueNotifier<List<UserNameModel>> userNameNotifier =
    ValueNotifier([]);

Future<void> addUser(UserNameModel data) async {
  final studentDB = await Hive.openBox<UserNameModel>("username_db");
  await studentDB.add(data);
  userNameNotifier.value.add(data);
  userNameNotifier.notifyListeners();
}

Future<void> getUser() async {
  final studentDB = await Hive.openBox<UserNameModel>("username_db");
  userNameNotifier.value.clear();
  userNameNotifier.value.addAll(studentDB.values);
  userNameNotifier.notifyListeners();
}

Future<void> clearUserData() async {
  final box = await Hive.openBox<UserNameModel>("username_db");
  await box.clear();
  userNameNotifier.value.clear();
  userNameNotifier.notifyListeners();
}

