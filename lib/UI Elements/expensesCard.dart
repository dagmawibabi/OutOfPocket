import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myexpensetracker/Model/boxes.dart';

class ExpensesCard extends StatefulWidget {
  const ExpensesCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.expense,
    required this.note,
    required this.date,
    required this.index,
    required this.areExpensesHidden,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final double expense;
  final String note;
  final String date;
  final int index;
  final bool areExpensesHidden;

  @override
  _ExpensesCardState createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
  Random random = Random();
  List listOfColors = [
    Colors.pink,
    Colors.green,
    Colors.black,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepOrange[900]!,
    Colors.blue,
    Colors.cyan,
    Colors.teal[900],
    Colors.red,
  ];
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.all(0.0),
        backgroundColor: Colors.white,
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        // Icon
        leading: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            //color: listOfColors[random.nextInt(9)],
            borderRadius: BorderRadius.circular(50.0),
            color: widget.areExpensesHidden ? Colors.black : Colors.transparent,
          ),
          child: Icon(
            widget.icon,
            color: widget.areExpensesHidden
                ? Colors.black
                : listOfColors[random.nextInt(9)],
          ),
        ),
        // Title
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            backgroundColor:
                widget.areExpensesHidden ? Colors.black : Colors.transparent,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        // Expense
        trailing: Container(
          width: 120.0,
          alignment: Alignment.centerRight,
          child: Text(
            widget.expense.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              backgroundColor:
                  widget.areExpensesHidden ? Colors.black : Colors.transparent,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Details
        children: [
          Divider(color: Colors.grey[400]),
          // Note, Date and Delete Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Note and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Note
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(top: 2.0, right: 2.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "📝 ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.note,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                backgroundColor: widget.areExpensesHidden
                                    ? Colors.black
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    // Date
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 14.0),
                      child: Row(
                        children: [
                          Text(
                            "⏳  ",
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.date,
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.black,
                                backgroundColor: widget.areExpensesHidden
                                    ? Colors.black
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Delete Button
              widget.areExpensesHidden
                  ? Container()
                  : IconButton(
                      icon: Icon(
                        isDeleted ? Icons.ac_unit : Icons.delete_forever,
                        color: Colors.pink[700],
                        size: 24.0,
                      ),
                      onPressed: () {
                        var box = Boxes.getExpenses();
                        isDeleted
                            ? setState(() {})
                            : box.deleteAt(widget.index);
                        isDeleted = true;
                        setState(() {});
                        //Navigator.pushReplacementNamed(context, "/");
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
