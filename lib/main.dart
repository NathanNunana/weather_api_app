import 'package:flutter/material.dart';

import 'package:whether_app/screens/home.dart';

void main() => runApp(MaterialApp(title: "Whether App", home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: HomePage(),
    );
  }
}
