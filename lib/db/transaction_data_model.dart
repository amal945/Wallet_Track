import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'transaction_data_model.g.dart';



@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  int amount;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String note;
  @HiveField(4)
  String category;
  @HiveField(5)
  String categoryType;

  TransactionModel({
    required this.amount,
    required this.date,
    required this.note,
    required this.category,
    required this.categoryType,
    String? id,
  }) : id = id ?? Uuid().v4();
}