import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class GraphsPage extends StatefulWidget {
  const GraphsPage({Key? key}) : super(key: key);

  @override
  _GraphsPageState createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage> {
  List<double> expenses = [];
  List<String> titles = [];
  List<String> expensesString = [];
  dynamic receivedData = [];
  void getExpenses() async {
    print(receivedData["data"][0].expense);
    titles.add("");
    expenses.add(0.0);
    expensesString.add("0");
    for (int i = 0; i < receivedData["data"].length; i++) {
      expenses.add(receivedData["data"][i].expense);
      expensesString.add(receivedData["data"][i].expense.toString());
    }
    expenses.add(0.0);
    expensesString.add("0");
    titles.add("");
    for (int i = 0; i < receivedData["data"].length; i++) {
      titles.add(receivedData["data"][i].title);
    }
  }

  @override
  Widget build(BuildContext context) {
    receivedData = ModalRoute.of(context)!.settings.arguments;
    receivedData["data"].length > 1 ? getExpenses() : () {};
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 150),
        child: receivedData["data"].length > 1
            ? LineGraph(
                features: [
                  Feature(
                    title: "Expenses",
                    color: Colors.pink,
                    data: expenses,
                  ),
                ],
                size: Size(370, 400),
                labelX: titles,
                labelY: expensesString,
                showDescription: true,
                graphColor: Colors.black,
                graphOpacity: 0.2,
                verticalFeatureDirection: false,
                descriptionHeight: 130,
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Graph can not be generated, \nPlease input some expenses!",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
