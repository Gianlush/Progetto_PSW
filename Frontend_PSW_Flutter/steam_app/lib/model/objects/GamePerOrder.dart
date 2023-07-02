
import 'Game.dart';
import 'Order.dart';

class GamePerOrder {
  int id;
  Order order;
  Game game;
  int quantity;


  GamePerOrder({this.id, this.order, this.game, this.quantity});

  factory GamePerOrder.fromJson(Map<String, dynamic> json) {
    return GamePerOrder(
      id: json['id'],
      game: Game.fromJson(json['game']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'game': game,
        'quantity': quantity,
      };
}
