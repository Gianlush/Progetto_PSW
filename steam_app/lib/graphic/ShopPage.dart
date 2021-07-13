import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/model/Model.dart';
import 'package:steam_app/model/objects/Game.dart';
import 'package:steam_app/model/widget/GameView.dart';
import 'package:steam_app/model/widget/MyInputField.dart';
import 'package:steam_app/model/widget/SearchButton.dart';
import 'package:steam_app/model/widget/AddToCartButton.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _shopPageState();
  }
}

class _shopPageState extends State<ShopPage>{

  List<Game> games;
  bool searching = false;
  int pageNumber = 1;
  String type;

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                parteSuperiore(),
                parteInferiore(),
                pageCounter(),
              ],
    );
  }

  Widget pageCounter() {
    if(games == null || (games.isEmpty && pageNumber==0))
      return SizedBox.shrink();
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            child: Icon(Icons.arrow_back_ios_sharp),
            onPressed: () => previous(),
          ),
          Text(pageNumber.toString(), style: TextStyle(color: Colors.black)),
          RawMaterialButton(
              child: Icon(Icons.arrow_forward_ios_sharp),
              onPressed: () => next()
          )
        ],
      );
  }


  Widget parteInferiore() {
    if(searching )
      return CircularProgressIndicator();
    else if(games == null)
      return SizedBox.shrink();
    else if(games.isEmpty && pageNumber == 1)
      return Text("NO RESULT!", style: TextStyle(fontSize: 25));
    else if (games.isEmpty && pageNumber != 1)
      return Expanded(child: Text("NO MORE RESULT!", style: TextStyle(fontSize: 25)));
    else
      return Flexible(
        child: Container(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GameView(games[index]),
                    AddToCartButton(games[index])
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
          Flexible(child: MyInputField(controller: textController, text: "Search: ",hint: "Sekiro",)),
          Text("Search by:",style: TextStyle(fontSize: 18),),
          searchButton("name",() => _search("name")),
          searchButton("genre",() => _search("genre"))
        ],
      ),
    );
  }

  next() {
    if(!games.isEmpty) {
      pageNumber++;
      _search(type);
    }
  }

  previous() {
    if(pageNumber != 1){
      pageNumber--;
      _search(type);
    }
  }

  _search(String type){
    setState(() {
      this.type=type;
      searching=true;
      games = null;
    });
    int page = pageNumber-1;
    Model.sharedInstance.searchGame(type: type, value: textController.text, pageNumber: page).then((value) {
      setState(() {
        searching = false;
        games = value;
      });
    });

  }

}

