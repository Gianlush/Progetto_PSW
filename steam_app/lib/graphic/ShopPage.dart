import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/model/widget/MyInputField.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _shopPageState();
  }
}

class _shopPageState extends State<ShopPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Column(
          children: [
            parteSuperiore(),
            //parteInferiore()
       ],
      )
    );
  }

}

class parteSuperiore extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Flexible(child: MyInputField()),
          RawMaterialButton(
            fillColor: Colors.purple,
            shape: CircleBorder(),
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.search),
              onPressed: () => _search()
           )
          )
        ],
      ),
    );
  }
  
}

//TODO
_search(){}
