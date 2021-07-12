import 'Game.dart';
import 'User.dart';

class Order {
  int id;
  int user;
  String shop_date;
  String payment_method;
  List<Game> game_per_order;


  Order({this.id, this.user, this.shop_date,this.game_per_order, this.payment_method});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['name'],
      shop_date: json['shop_date'],
      game_per_order: json['game_per_order'],
      payment_method :json['payment_method']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': user,
    'shop_date': shop_date,
    'payment_method': payment_method,
    'game_oer_order':game_per_order
  };

 /* @override
  String toString() {
  }*/


}