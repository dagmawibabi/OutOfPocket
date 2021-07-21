import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

part 'expenseModel.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  late String icon;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late double expense;

  @HiveField(3)
  late String note;

  @HiveField(4)
  late String date;
}

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  late String username;
}

@HiveType(typeId: 2)
class BudgetModel extends HiveObject {
  @HiveField(1)
  late double budget;

  @HiveField(2)
  late double warningLimit;
}

@HiveType(typeId: 3)
class SettingsModel extends HiveObject {
  @HiveField(3)
  late bool isDarkMode;
}
