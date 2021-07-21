import 'package:hive/hive.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';

class Boxes {
  static Box<ExpenseModel> getExpenses() => Hive.box("Expenses");
  static Box<UserModel> getUserModel() => Hive.box("UserModel");
  static Box<BudgetModel> getBudgetModel() => Hive.box("BudgetModel");
  static Box<SettingsModel> getSettingsModel() => Hive.box("SettingsModel");
}
