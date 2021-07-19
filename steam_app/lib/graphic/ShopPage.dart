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
  String lastSearchBy = "";
  String lastSortBy = "";
  String lastValue = "";

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
      return Padding(
          child: Opacity(child: Icon(Icons.shopping_basket_outlined,size: 300, color: Colors.deepPurple), opacity: 0.65),
          padding: EdgeInsets.fromLTRB(0, 300, 0, 0)
      );
    else if(games.isEmpty && pageNumber == 1)
      return Expanded(child: Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0),child: Text("NO RESULT!", style: TextStyle(fontSize: 35))));
    else
      return Flexible(
        child: Container(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    if(lastSearchBy == "name")
      return Padding(
        padding: EdgeInsets.fromLTRB(10,10,10,10),
        child: Row(
          children: [
            Flexible(child: MyInputField(controller: textController, text: "Search: ",hint: "Example: Sekiro",)),
            Text("Search by:",style: TextStyle(fontSize: 18),),
            searchButton("name",() => _search(1, value: textController.text, searchBy: "name")),
            searchButton("genre",() => _search(1, value: textController.text, searchBy: "genre")),
            Text("Order by:",style: TextStyle(fontSize: 18)),
            searchButton("genre",() => _search(1, value: lastValue, searchBy: lastSearchBy, sortBy: "genre")),
            searchButton("price",() => _search(1, value: lastValue, searchBy: lastSearchBy, sortBy: "price",)),
          ],
        ),
      );
    else if(lastSearchBy == "genre")
      return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(child: MyInputField(controller: textController, text: "Search: ",hint: "Sekiro",)),
            Text("Search by:",style: TextStyle(fontSize: 18),),
            searchButton("name",() => _search(1 , value: textController.text, searchBy: "name")),
            searchButton("genre",() => _search(1, value: textController.text, searchBy: "genre")),
            Text("Order by:",style: TextStyle(fontSize: 18)),
            searchButton("name",() => _search(1, value: lastValue, searchBy: lastSearchBy, sortBy: "name")),
            searchButton("price",() => _search(1, value: lastValue, searchBy: lastSearchBy, sortBy: "price",)),
          ],
        ),
      );
    else
      return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(child: MyInputField(controller: textController, text: "Search: ",hint: "Sekiro",)),
            Text("Search by:",style: TextStyle(fontSize: 18),),
            searchButton("name",() => _search(1, value: textController.text, searchBy: "name")),
            searchButton("genre",() => _search(1, value: textController.text, searchBy: "genre")),
          ],
        ),
      );
  }

  next() {
    if(games.length == 7) {
      pageNumber++;
      _search(pageNumber, value: lastValue, sortBy: lastSortBy, searchBy: lastSearchBy);
    }
  }

  previous() {
    if(pageNumber != 1){
      pageNumber--;
      _search(pageNumber, value: lastValue, sortBy: lastSortBy, searchBy: lastSearchBy);
    }
  }

  _search(int page, {String value, String searchBy, String sortBy="name"}){

    lastValue = value;
    lastSearchBy = searchBy;
    lastSortBy = sortBy;
    pageNumber = page;

    setState(() {
      searching=true;
    });

    page = pageNumber-1;
    Model.sharedInstance.searchGame(type: searchBy, value: value, pageNumber: page, sortBy: sortBy).then((value) {
      setState(() {
        searching = false;
        games = value;
      });
    });

  }

}

