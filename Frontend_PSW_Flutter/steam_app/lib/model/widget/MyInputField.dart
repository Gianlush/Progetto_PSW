import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget{
  final TextEditingController controller;
  final String text;
  final String hint;
  final bool isPassword;

  const MyInputField({Key key, this.controller, this.text, this.hint, this.isPassword=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5,5,15,5),
        child: TextField(
          obscureText: isPassword,
          controller: controller,
          decoration: InputDecoration(
            labelText: text,
            hintText: hint,
            fillColor: Colors.blueGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            )
          ),
        ),
    );
  }

}