import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class UserNameModel {
  @HiveField(0)
  final String? userName;

  UserNameModel([this.userName]);
}
