import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/model/objects/Game.dart';

class ShopButton extends StatelessWidget {
  final Game game;

  const ShopButton(this.game, {Key key}) : super(key: key);

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
         Icon(Icons.shopping_cart)
       ],
      ),
     )
   );
  }

  addToCart(Game game){
    //TODO
    //if(AccountPage.user == null ) return "LOGIN FIRST";
  }



}