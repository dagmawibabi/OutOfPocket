import 'dart:async';

import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void timer() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "homePage");
    });
  }

  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: //Color(0xff1a1a1a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              "assets/images/logo.png",
              width: 120.0,
              height: 120.0,
            ),
            SizedBox(height: 10.0),
            Text(
              "Out Of Pocket",
              style: TextStyle(
                //color: Color(0xff1a1a1a),
                fontSize: 21.0,
              ),
            ),
            Text(
              "Manage Your Expenses",
              style: TextStyle(
                //color: Color(0xff1a1a1a),
                fontSize: 15.0,
              ),
            ),
            Spacer(),
            Text(
              "Made with 💚 by dream intelligence.",
              style: TextStyle(
                //color: Color(0xff1a1a1a),
                fontSize: 10.0,
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
