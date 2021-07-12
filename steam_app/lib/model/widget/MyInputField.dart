import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget{
  final TextEditingController controller;

  const MyInputField({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5,5,15,5),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: "Search",
            fillColor: Colors.blueGrey,
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
    );
  }

}