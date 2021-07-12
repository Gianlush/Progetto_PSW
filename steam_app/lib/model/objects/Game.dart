class Game {
  int id;
  String name;
  String genre;
  double price;
  int quantity;



  Game({this.id, this.name, this.genre, this.quantity, this.price});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      genre: json['genre'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'genre': genre,
    'price': price,
    'quantity':quantity,
  };

  @override
  String toString() {
    return name;
  }


}