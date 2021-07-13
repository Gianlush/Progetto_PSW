class Game {
  int id;
  String name;
  String genre;
  double price;
  int quantityAvailable;



  Game({this.id, this.name, this.genre, this.quantityAvailable, this.price});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      genre: json['genre'],
      price: json['price'],
      quantityAvailable: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'genre': genre,
    'price': price,
    'quantity':quantityAvailable,
  };

  @override
  String toString() {
    return name;
  }

  bool equals(Game game){
    if(this.name==game.name && this.genre==game.genre)
      return true;
    else
      return false;
  }
}