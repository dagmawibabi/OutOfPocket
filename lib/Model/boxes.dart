import 'package:hive/hive.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';

class Boxes {
  static Box<ExpenseModel> getExpenses() => Hive.box("Expenses");
}
