import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/graphic/CartPage.dart';
import 'package:steam_app/model/objects/Game.dart';
import 'package:steam_app/model/objects/GamePerOrder.dart';

class AddToCartButton extends StatelessWidget {
  final Game game;

  const AddToCartButton(this.game, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return RawMaterialButton(
     onPressed: () => addToCart(game),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
     fillColor: Colors.deepPurple,
     child: Padding(
       padding: EdgeInsets.all(20),
       child: Row(
         children: [
         Text("Add to Cart", style: TextStyle(color: Colors.white)),
         Icon(Icons.add_shopping_cart)
       ],
      ),
     )
   );
  }

  addToCart(Game game){
    GamePerOrder newGame = CartPageState.order.searchEqualGame(game);
    if(newGame != null) {
      newGame.quantity++;
    }
    else {
      CartPageState.order.gamePerOrder.add(GamePerOrder(game: game, quantity: 1));
    }
  }
}