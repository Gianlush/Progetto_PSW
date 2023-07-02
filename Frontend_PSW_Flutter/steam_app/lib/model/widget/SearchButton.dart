import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchButton extends StatelessWidget {
  final String text;
  final Function function;

  searchButton(this.text, this.function, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.deepPurple,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          onPressed: function,
        ),
    );
  }

}