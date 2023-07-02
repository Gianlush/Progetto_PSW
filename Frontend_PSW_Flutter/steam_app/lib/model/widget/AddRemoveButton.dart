import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/graphic/CartPage.dart';
import 'package:steam_app/model/objects/GamePerOrder.dart';

class AddRemoveButton extends StatelessWidget{

  final GamePerOrder game;
  final Function function;

  const AddRemoveButton(this.function, this.game, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(color: Colors.deepPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          RawMaterialButton(
            child: Icon(Icons.remove),
            onPressed: () => remove(),
          ),
          Text(game.quantity.toString(), style: TextStyle(color: Colors.white, fontSize: 15)),
          RawMaterialButton(
              child: Icon(Icons.add),
              onPressed: () => add()
          )
        ],
      ),
    );
  }

  add() {
    game.quantity++;
    function();
  }

  remove() {
    game.quantity--;
    if(game.quantity==0)
      CartPageState.order.gamePerOrder.remove(game);
    function();
  }


}