import 'Game.dart';
import 'GamePerOrder.dart';
import 'User.dart';

class Order {
  int id;
  int user;
  DateTime shopDate;
  String paymentMethod;
  List<GamePerOrder> gamePerOrder;


  Order({this.id, this.user, this.shopDate,this.gamePerOrder, this.paymentMethod});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user'],
      shopDate: json['shopDate'],
      gamePerOrder: json['gamePerOrder'],
      paymentMethod :json['paymentMethod']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': User(id: user).toJson(),
    'paymentMethod': paymentMethod,
    'gamePerOrder':gamePerOrder
  };

  GamePerOrder searchEqualGame(Game game){
    for(int i=0;i<gamePerOrder.length;i++){
      if(gamePerOrder[i].game.equals(game))
        return gamePerOrder[i];
      else
        return null;
    }
  }


}