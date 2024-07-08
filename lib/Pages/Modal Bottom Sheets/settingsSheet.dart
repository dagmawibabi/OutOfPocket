import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:myexpensetracker/Model/boxes.dart';

import '../../Model/expenseModel.dart';

Future<dynamic> settingsModalBottomSheet(BuildContext context) async {
  final settingsBox = await Hive.openBox<SettingsModel>('SettingsModel');
  final currentSettings =
      settingsBox.get('settingsKey', defaultValue: SettingsModel());
  bool isDarkMode = currentSettings?.isDarkMode ?? false;
  void resetData() async {
    var box;
    box = Boxes.getUserModel();
    await box.clear();
    box = Boxes.getBudgetModel();
    await box.clear();
    box = Boxes.getExpenses();
    await box.clear();
    box = Boxes.getSettingsModel();
    await box.clear();
    Navigator.pushReplacementNamed(context, "homePage");
  }

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 650.0,
            color: Theme.of(context).primaryColor,
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
                // Settings Title
                Text(
                  "⚙",
                  style: TextStyle(
                    fontSize: 38.0,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                // Dark Mode
                GestureDetector(
                  onTap: () async {
                    bool newIsDarkMode = !isDarkMode;
                    currentSettings?.isDarkMode = newIsDarkMode;
                    await settingsBox.put('settingsKey', currentSettings!);
                    setState(() {
                      isDarkMode = newIsDarkMode;
                    });
                    if (newIsDarkMode) {
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          statusBarColor: Colors.grey[900],
                          statusBarIconBrightness: Brightness.light,
                        ),
                      );
                    } else {
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          statusBarColor: Colors.grey[200],
                          statusBarIconBrightness: Brightness.dark,
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 80.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isDarkMode ? "Light Mode" : "Dark Mode",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                // Reset Data
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 80.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Reset Data",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    resetData();
                  },
                ),
                // Save Button
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
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
              ],
            ),
          );
        },
      );
    },
  );
}
