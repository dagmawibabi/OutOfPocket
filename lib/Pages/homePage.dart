import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myexpensetracker/Model/boxes.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';
import 'package:myexpensetracker/Pages/Modal%20Bottom%20Sheets/addBudgetSheet.dart';
import 'package:myexpensetracker/Pages/Modal%20Bottom%20Sheets/editProfileSheet.dart';
import 'package:myexpensetracker/UI%20Elements/expensesCard.dart';
import 'package:myexpensetracker/listOfIcons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double initialBudget = 0.00;
  double totalExpenses = 0.00;
  double remainingBudget = 0.00;
  double budgetLimit = 0;
  List listOfExpenses = [];
  bool isSorted = false;
  bool isAscending = true;
  int sortChoice = 0;
  int hideChoice = 0;
  bool areExpensesHidden = false;
  bool isBudgetCardHidden = false;
  // Calculate Expenses
  void getExpenses() {
    var box = Boxes.getExpenses();
    List instanceList = box.values.toList();
    // Reset Vars
    listOfExpenses = [];
    totalExpenses = 0;
    remainingBudget = initialBudget;
    // Decrease each expense from the budget
    for (int i = 0; i < instanceList.length; i++) {
      listOfExpenses.add(instanceList[i]);
      remainingBudget -= listOfExpenses[i].expense;
      totalExpenses += listOfExpenses[i].expense;
    }
    // Sort algo
    late double smallestExpense;
    List sorted = [];
    List unsorted = [];
    for (int i = 0; i < instanceList.length; i++) {
      unsorted.add(instanceList[i]);
    }
    //
    dynamic expenseObj;
    int goal = unsorted.length;
    int curGoal = 0;
    int removeIndex = 0;
    if (isSorted) {
      while (curGoal < goal) {
        for (int i = 0; i < unsorted.length; i++) {
          smallestExpense = unsorted[i].expense;
          for (int j = 0; j < unsorted.length; j++) {
            // Ascending
            if (isAscending) {
              if (unsorted[j].expense < smallestExpense) {
                smallestExpense = unsorted[j].expense;
                expenseObj = unsorted[j];
                removeIndex = j;
              }
            }
            // Decending
            else {
              if (unsorted[j].expense > smallestExpense) {
                smallestExpense = unsorted[j].expense;
                expenseObj = unsorted[j];
                removeIndex = j;
              }
            }
            if (curGoal + 1 == goal) {
              smallestExpense = unsorted[j].expense;
              expenseObj = unsorted[j];
              removeIndex = j;
            }
          }
        }

        sorted.add(expenseObj);
        curGoal++;
        unsorted.removeAt(removeIndex);
        removeIndex = 0;
      }
    }

    //
    print("==================================================================");
    for (int i = 0; i < sorted.length; i++) {
      print(sorted[i].expense);
      listOfExpenses = sorted;
    }
    print("==================================================================");
    //
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getExpenses();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getExpenses();
    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Out Of Pocket",
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),*/
      body: ListView(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome User Message, Profile Button and Add Budget Button
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Button and Add Budget Button
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          // Edit Profile Button
                          IconButton(
                            onPressed: () {
                              editProfileModalBottomSheet(context);
                            },
                            icon: Icon(
                              Icons.account_circle_outlined,
                              size: 30.0,
                            ),
                          ),
                          // Add Budget Button
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "💰  ",
                                ),
                              ),
                              Positioned(
                                left: 7.0,
                                bottom: 23.0,
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xffac924c),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Welcome User Message
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Hello, 👋 \nDagmawi.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Settings and Refresh
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Refresh Button
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh,
                      ),
                    ),

                    // Settings Button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          // Burget Card
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              boxShadow:
                  double.parse(remainingBudget.toStringAsFixed(2)) < budgetLimit
                      ? [
                          BoxShadow(
                            color: Colors.deepOrangeAccent,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.pinkAccent,
                            spreadRadius: 2.0,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Color(0xff12fff7),
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Color(0xffb3ffab),
                            spreadRadius: 2.0,
                          ),
                        ],
              gradient: LinearGradient(
                colors: double.parse(remainingBudget.toStringAsFixed(2)) <
                        budgetLimit
                    ? [
                        Colors.pinkAccent,
                        Colors.deepOrangeAccent,
                      ]
                    : [
                        Color(0xffb3ffab),
                        Color(0xff12fff7),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              color: Colors.grey[200],
              /* border: Border.all(
                color: Colors.black,
              ),*/
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Total Remaining Budget
                Column(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/birrSymbol_remainingBudget.png",
                          width: 30.0,
                          height: 30.0,
                        ),
                        SizedBox(width: 2.0),
                        Text(
                          remainingBudget.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.black,
                            backgroundColor: isBudgetCardHidden
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                // Initial Budget and Total expenses
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Initial Budget
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/birrSymbol_initialBudget.png",
                                  width: 15.0,
                                  height: 15.0,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  initialBudget.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: isBudgetCardHidden
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Budget",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        addBudgetModalBottomSheet(context);
                      },
                    ),
                    // Total Expenses
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/birrSymbol_initialBudget.png",
                                width: 15.0,
                                height: 15.0,
                              ),
                              SizedBox(width: 2.0),
                              Text(
                                totalExpenses.toStringAsFixed(2),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: isBudgetCardHidden
                                      ? Colors.black
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          // Expenses Title and Currency
          listOfExpenses.length > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Expenses Title + Hide Button
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(
                          "Expenses",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            //fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (hideChoice == 0) {
                          areExpensesHidden = !areExpensesHidden;
                        } else if (hideChoice == 1) {
                          isBudgetCardHidden = !isBudgetCardHidden;
                        } else {
                          areExpensesHidden = false;
                          isBudgetCardHidden = false;
                          hideChoice = -1;
                        }
                        hideChoice++;
                        setState(() {});
                      },
                    ),
                    // Currency + Sort Button
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Image.asset(
                          "assets/images/birrSymbol_initialBudget.png",
                          width: 17.0,
                          height: 17.0,
                        ),
                      ),
                      onTap: () {
                        if (sortChoice == 2) {
                          isSorted = false;
                          isAscending = true;
                          sortChoice = 0;
                          setState(() {});
                        } else {
                          isSorted = true;
                          isAscending = !isAscending;
                          setState(() {});
                        }
                        sortChoice++;
                      },
                    ),
                  ],
                )
              : Container(),
          // Expenses
          ListView.builder(
            shrinkWrap: true,
            itemCount: listOfExpenses.length,
            itemBuilder: (context, index) {
              return ExpensesCard(
                icon: ListOfIcons
                    .listOfIcons[int.parse(listOfExpenses[index].icon)],
                title: listOfExpenses[index].title,
                expense: listOfExpenses[index].expense,
                note: listOfExpenses[index].note,
                date: listOfExpenses[index].date,
                index: index,
                areExpensesHidden: areExpensesHidden,
              );
            },
          ),
          // Delete All button and No expenses message
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              listOfExpenses.length > 0
                  // Delete All Button
                  ? areExpensesHidden
                      ? Container()
                      : GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 6.0, right: 10.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
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
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(
                              "Delete All",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            var box = Boxes.getExpenses();
                            box.clear();
                            setState(() {});
                          },
                        )
                  // No expenses message
                  : Expanded(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            //border: Border(
                            //top: BorderSide(color: Colors.grey[400]!))
                            //border: Border.all(color: Colors.grey),
                            //borderRadius: BorderRadius.circular(20.0),
                            ),
                        margin: EdgeInsets.all(30.0),
                        child: Text(
                          "You have no expenses!",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          // Extra Space
          SizedBox(height: 200.0),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Color(0xee12fff7),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28.0,
        ),
        onPressed: () {
          Navigator.pushNamed(context, "addExpensePage");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

/* GRADIENTS
Color(0xffaaffa9),
Color(0xff11ffbd),

Color(0xffb3ffab),
Color(0xff12fff7),

Color(0xff556270),
Color(0xffff6b6b),

Colors.deepPurpleAccent,
Colors.pinkAccent,
Colors.deepOrangeAccent,
Colors.pinkAccent,
Colors.deepPurpleAccent,
*/
