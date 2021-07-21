import 'package:flutter/material.dart';
import 'package:myexpensetracker/Model/boxes.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';

Future<dynamic> addBudgetModalBottomSheet(BuildContext context) {
  void saveBudgetAndLimit(double budget, double warningLimit) async {
    BudgetModel budgetAndLimit = BudgetModel()
      ..budget = budget
      ..warningLimit = warningLimit;
    var box = Boxes.getBudgetModel();
    await box.clear();
    await box.add(budgetAndLimit);
    Navigator.pushReplacementNamed(context, "homePage");
  }

  TextEditingController budgetController = TextEditingController();
  TextEditingController budgetLimitController = TextEditingController();
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: 700.0,
        color: Colors.grey[200],
        child: Column(
          children: [
            // Back Button
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            // Cash Emoji
            Text(
              "💰",
              style: TextStyle(fontSize: 34.0),
            ),
            SizedBox(height: 20.0),
            // Input Your Initial Budget
            Text(
              "How much is your budget?",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            // Initial Budget Input Box
            Container(
              margin: EdgeInsets.symmetric(horizontal: 80.0),
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                children: [
                  /*Text(
                    "✍",
                    style: TextStyle(fontSize: 18.0),
                  ),*/
                  Text("💰"),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.grey[900],
                      ),
                      keyboardType: TextInputType.number,
                      controller: budgetController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: "enter your budget",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.0),
            // Budget Limit
            Text(
              "Warn when budget drops to?",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            // Budget Limit Input Box
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70.0),
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                children: [
                  /*Text(
                    "✍",
                    style: TextStyle(fontSize: 18.0),
                  ),*/
                  Text("💰"),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.grey[900],
                      ),
                      keyboardType: TextInputType.number,
                      controller: budgetLimitController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: "enter warning amount",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Save Button
            GestureDetector(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 70.0),
                decoration: BoxDecoration(
                  /*gradient: LinearGradient(
                        colors: [
                          Color(0xffb3ffab),
                          Color(0xff12fff7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),*/
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(50.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                saveBudgetAndLimit(double.parse(budgetController.text),
                    double.parse(budgetLimitController.text));
              },
            ),
          ],
        ),
      );
    },
  );
}
