
import 'package:flutter/material.dart';
import 'package:steam_app/model/utility/Constants.dart';

import 'graphic/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.TITLE_APP,
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          backgroundColor: Colors.deepPurple,
          buttonColor: Colors.blueAccent,
        ),
      home: MainScreen(),
    );
  }

}

