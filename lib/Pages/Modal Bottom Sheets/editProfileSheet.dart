import 'package:flutter/material.dart';
import 'package:myexpensetracker/Model/boxes.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';

Future<dynamic> editProfileModalBottomSheet(BuildContext context) {
  void saveUserModel(String username) async {
    UserModel userModel = UserModel()..username = username;
    var box = Boxes.getUserModel();
    await box.clear();
    await box.add(userModel);
    Navigator.pushReplacementNamed(context, "homePage");
  }

  TextEditingController usernameController = TextEditingController();
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: 650.0,
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
            // Hello What's your name
            Text(
              "👋😊",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 10.0),
            Text(
              "What's your name?",
              style: TextStyle(fontSize: 26.0),
            ),
            SizedBox(height: 20.0),
            // Input Box
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
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
                  /*Icon(Icons.account_circle_outlined),*/
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.grey[900],
                      ),
                      controller: usernameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: "enter your first name",
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
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
                saveUserModel(usernameController.text);
              },
            ),
          ],
        ),
      );
    },
  );
}
