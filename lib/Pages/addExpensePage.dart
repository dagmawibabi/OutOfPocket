import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myexpensetracker/Model/boxes.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';
import 'package:myexpensetracker/listOfIcons.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  int chosenIcon = -1;
  bool iconsExpanded = false;
  List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  /*List days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];*/
  /*List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];*/
  List months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  String pickADateTitle = "Pick a date";
  late String chosenDate;

  TextEditingController titleController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // Register Expense
  void registerExpense(
      String icon, String title, double expense, String note, String date) {
    ExpenseModel currentExpense = ExpenseModel()
      ..icon = icon
      ..title = title
      ..expense = expense
      ..note = note
      ..date = date.toString();
    final box = Boxes.getExpenses();
    box.add(currentExpense);
    setState(() {});
    Navigator.pushReplacementNamed(context, "homePage");
  }

  @override
  void initState() {
    super.initState();
    // Set initial date incase user doesn't specify date
    int currentWeekday = DateTime.now().weekday;
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    chosenDate = days[currentWeekday - 1].toString() +
        ", " +
        currentDay.toString() +
        " - " +
        months[currentMonth].toString() +
        " - " +
        currentYear.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Back Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
          // Add Expense Title
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add Expenses Message
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                  child: Text(
                    "\t\t Add 💰\nExpenses ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Input Expenses
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Choose an Icon
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      chosenIcon == -1
                          ? Icons.adjust_rounded
                          : ListOfIcons.listOfIcons[chosenIcon],
                      color: Colors.black,
                    ),
                    title: Text(
                      "Choose an Icon",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      iconsExpanded
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      color: Colors.black,
                    ),
                    onExpansionChanged: (expansionState) {
                      iconsExpanded = expansionState;
                      setState(() {});
                    },
                    tilePadding: EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      Divider(
                        color: Colors.grey[400],
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 76,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: ListOfIcons.listOfIcons.length,
                            itemBuilder: (context, index) {
                              return IconButton(
                                icon: Icon(
                                  ListOfIcons.listOfIcons[index],
                                  color: index == chosenIcon
                                      ? Colors.deepOrangeAccent
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  chosenIcon = index;
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Enter Title
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "✍",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                          controller: titleController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            labelText: "enter a short title",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Enter Expense Amount
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "💰",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                          keyboardType: TextInputType.number,
                          controller: expenseController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            labelText: "enter how much you spent",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Enter Extra Note
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "📝",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                          controller: noteController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            labelText: "enter a descriptive note",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.0),
                // Pick a date
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
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
                      pickADateTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((date) {
                      chosenDate = days[date!.weekday - 1] +
                          ", " +
                          date.day.toString() +
                          " - " +
                          months[date.month] +
                          " - " +
                          date.year.toString();
                      pickADateTitle = chosenDate;
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Color(0xee12fff7),
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 28.0,
        ),
        onPressed: () {
          // Register Expense
          registerExpense(
            chosenIcon == -1 ? "Icons.adjust_rounded" : chosenIcon.toString(),
            titleController.text,
            double.parse(expenseController.text),
            noteController.text,
            chosenDate,
          );
        },
      ),
    );
  }
}
