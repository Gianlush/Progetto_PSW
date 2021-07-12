import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/model/Model.dart';
import 'package:steam_app/model/objects/Game.dart';
import 'package:steam_app/model/widget/GameView.dart';
import 'package:steam_app/model/widget/MyInputField.dart';
import 'package:steam_app/model/widget/SearchButton.dart';
import 'package:steam_app/model/widget/ShopButton.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _shopPageState();
  }
}

class _shopPageState extends State<ShopPage>{

  List<Game> games;
  bool _searching = false;

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                parteSuperiore(),
                parteInferiore()
              ],
    );
  }
  Widget parteInferiore() {
    if(_searching )
      return CircularProgressIndicator();
    else if(games == null)
      return SizedBox.shrink();
    else if(games.isEmpty)
      return Text("NO RESULT!", style: TextStyle(fontSize: 25));
    else
      return Expanded(
        child: Container(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GameView(games[index]),
                    ShopButton(games[index])
                  ]
              );
            },
          ),
        ),
      );
  }

  Widget parteSuperiore () {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: MyInputField(controller: textController,)),
          Text("Search by:",style: TextStyle(fontSize: 18),),
          searchButton("name",() => _search("name")),
          searchButton("genre",() => _search("genre"))
        ],
      ),
    );
  }

  _search(String type){
    setState(() {
      _searching=true;
      games = null;
    });
    Model.sharedInstance.searchGame(type: type, value: textController.text).then((value) {
      setState(() {
        _searching = false;
        games = value;
      });
    });

  }

}

