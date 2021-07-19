import 'dart:convert';
import 'dart:io';

import 'Game.dart';
import 'GamePerOrder.dart';
import 'User.dart';

class Order {
  int id;
  int user;
  double total;
  DateTime shopDate;
  String paymentMethod;
  List<GamePerOrder> gamePerOrder;


  Order({this.id, this.user, this.shopDate,this.gamePerOrder, this.paymentMethod, this.total});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user']['id'],
      total: json['total'],
      shopDate: Order.toDate(json['shopDate']),
      gamePerOrder: (json['gamePerOrder'] as List).map((i) => GamePerOrder.fromJson(i)).toList(),
      paymentMethod :json['paymentMethod']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': User(id: user).toJson(),
    'paymentMethod': paymentMethod,
    'gamePerOrder':gamePerOrder
  };
  
  static DateTime toDate(String date){
    List<int> list = date.split("-").map((i) => int.parse(i)).toList();
    print(list);
    return DateTime(list[0],list[1],list[2],list[3],list[4]);
  }

  GamePerOrder searchEqualGame(Game game){
    for(int i=0;i<gamePerOrder.length;i++){
      if(gamePerOrder[i].game.equals(game))
        return gamePerOrder[i];
      else
        return null;
    }
  }


}