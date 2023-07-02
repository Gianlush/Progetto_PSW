import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/model/objects/Game.dart';

class GameView extends StatelessWidget {
  final Game game;

  const GameView(this.game, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          decoration: ShapeDecoration(color: Colors.deepPurple, shape: RoundedRectangleBorder(side: BorderSide(color: Colors.deepPurple, width: 15),borderRadius: BorderRadius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyContainer(infoType: "Game",value: game.name),
              MyContainer(infoType: "Genre",value: game.genre),
              MyContainer(infoType: "Price",value: game.price.toString()+"€"),
              MyContainer(infoType: "Available",value: game.quantityAvailable.toString()),
            ],
          ),
        )
    );
  }
}

  Widget MyContainer({infoType: String, value: String}) {
    return Container(
        width: 270,
        child: Row(
            children: [
              Text(
                  infoType+":",
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )
              ),
              Expanded(
                  child: Text("  "+value,
                      softWrap: true,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.greenAccent,
                        fontSize: 20,
                      )
                  )
              )
            ]
        )
    );
}